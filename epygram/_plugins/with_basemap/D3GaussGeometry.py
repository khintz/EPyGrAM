#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Copyright (c) Météo France (2014-)
# This software is governed by the CeCILL-C license under French law.
# http://www.cecill.info
"""
Contains the Basemap-interfaced facilities to plot field.

.. deprecated:: 1.3.11
"""
from __future__ import print_function, absolute_import, unicode_literals, division

from mpl_toolkits.basemap import Basemap


def activate():
    """Activate extension."""
    from . import __name__ as plugin_name
    from epygram._plugins.util import notify_doc_requires_plugin
    notify_doc_requires_plugin([make_basemap,],
                               plugin_name)
    from epygram.geometries.D3Geometry import D3GaussGeometry
    D3GaussGeometry.make_basemap = make_basemap


def make_basemap(self,
                 gisquality='l',
                 specificproj=None,
                 zoom=None,
                 ax=None,
                 **_):
    """
    Returns a :class:`matplotlib.basemap.Basemap` object of the 'ad hoc'
    projection (if available). This is designed to avoid explicit handling
    of deep horizontal geometry attributes.

    :param gisquality: defines the quality of GIS contours, cf. Basemap doc. \n
      Possible values (by increasing quality): 'c', 'l', 'i', 'h', 'f'.
      WARNING: this is forced to 'l' inside (except if a zoom is given),
      for time-consumption reasons.
    :param specificproj: enables to make basemap on the specified projection,
      among: 'kav7', 'cyl', 'ortho', ('nsper', {...}) (cf. Basemap doc). \n
      In 'nsper' case, the {} may contain:\n
      - 'sat_height' = satellite height in km;
      - 'lon' = longitude of nadir in degrees;
      - 'lat' = latitude of nadir in degrees. \n
      Overwritten by *zoom*.
    :param zoom: specifies the lon/lat borders of the map, implying hereby a
      'cyl' projection.
      Must be a dict(lonmin=, lonmax=, latmin=, latmax=). \n
      Overwrites *specificproj*.
    :param ax: a matplotlib ax on which to plot; if None, plots will be done
      on matplotlib.pyplot.gca()
    """
    # !!! **_ enables the method to receive arguments specific to
    #     other geometries, useless here ! Do not remove.
    if zoom is None:
        gisquality = 'l'  # forced for Gauss, for time-consumption reasons...

    # corners
    llcrnrlon = -180
    llcrnrlat = -90
    urcrnrlon = 180
    urcrnrlat = 90

    # make basemap
    if zoom is not None:
        # zoom case
        llcrnrlon = zoom['lonmin']
        llcrnrlat = zoom['latmin']
        urcrnrlon = zoom['lonmax']
        urcrnrlat = zoom['latmax']
        if llcrnrlat <= -89.0 or \
           urcrnrlat >= 89.0:
            specificproj = 'cyl'
        else:
            specificproj = 'merc'
    if specificproj is None:
        # defaults
        if 'rotated' in self.name:
            lon0 = self.grid['pole_lon'].get('degrees')
        else:
            lon0 = 0.0
        b = Basemap(resolution=gisquality, projection='moll',
                    lon_0=lon0,
                    ax=ax)
    else:
        # specificproj
        if 'rotated' in self.name:
            lon0 = self.grid['pole_lon'].get('degrees')
            lat0 = self.grid['pole_lat'].get('degrees')
        else:
            lon0 = 0.0
            lat0 = 0.0
        if specificproj == 'kav7':
            b = Basemap(resolution=gisquality, projection=specificproj,
                        lon_0=lon0,
                        llcrnrlon=llcrnrlon, llcrnrlat=llcrnrlat,
                        urcrnrlon=urcrnrlon, urcrnrlat=urcrnrlat,
                        ax=ax)
        elif specificproj == 'ortho':
            b = Basemap(resolution=gisquality, projection=specificproj,
                        lon_0=lon0,
                        lat_0=lat0,
                        ax=ax)
        elif specificproj in ('cyl', 'merc'):
            b = Basemap(resolution=gisquality, projection=specificproj,
                        llcrnrlon=llcrnrlon, llcrnrlat=llcrnrlat,
                        urcrnrlon=urcrnrlon, urcrnrlat=urcrnrlat,
                        ax=ax)
        elif specificproj == 'moll':
            b = Basemap(resolution=gisquality, projection=specificproj,
                        lon_0=lon0,
                        llcrnrlon=llcrnrlon, llcrnrlat=llcrnrlat,
                        urcrnrlon=urcrnrlon, urcrnrlat=urcrnrlat,
                        ax=ax)
        elif isinstance(specificproj, tuple) and \
             specificproj[0] == 'nsper' and \
             isinstance(specificproj[1], dict):
            sat_height = specificproj[1].get('sat_height', 3000) * 1000.
            b = Basemap(resolution=gisquality,
                        projection=specificproj[0],
                        lon_0=specificproj[1].get('lon', lon0),
                        lat_0=specificproj[1].get('lat', lat0),
                        satellite_height=sat_height,
                        ax=ax)

    return b