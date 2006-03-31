From: terra@gnome.org (Morten Welinder)
Subject: Incorrect scoping
Date: Fri, 31 Mar 2006 17:05:33 -0500 (EST)
Message-ID: <20060331220533.69B67C000E2@dunnock.rentec.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from unicorn.rentec.com ([216.223.240.10]:42211 "EHLO
	unicorn.rentec.com") by vger.kernel.org with ESMTP id S1751407AbWCaWFp
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 31 Mar 2006 17:05:45 -0500
Received: from wren.rentec.com (wren [192.5.35.106])
	by unicorn.rentec.com (8.13.6/8.12.1) with ESMTP id k2VM5iJh003233
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Fri, 31 Mar 2006 17:05:45 -0500 (EST)
Received: from dunnock.rentec.com (dunnock.rentec.com [172.26.132.207])
	by wren.rentec.com (8.13.1/8.12.1) with ESMTP id k2VM5XxS017193
	for <linux-sparse@vger.kernel.org>; Fri, 31 Mar 2006 17:05:33 -0500 (EST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Sparse fails to detect this scoping monster:

typedef int typ;
static void typ (void) { }

gcc says...

foo.c:2: error: `typ' redeclared as different kind of symbol
foo.c:1: error: previous declaration of `typ'

M.
