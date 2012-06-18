From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 0/2] Add some more ignored attributes for glibc
Date: Mon, 18 Jun 2012 14:06:59 +0300
Message-ID: <cover.1340005296.git.dan.carpenter@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:39112 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab2FRLHI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 18 Jun 2012 07:07:08 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: KOSAKI Motohiro <kosaki.motohiro@gmail.com>

KOSAKI Motohiro sent these patches to Smatch and I'm pushing them
upstream.

Smatch wasn't using the latest Sparse so I've tweaked them a bit.

KOSAKI Motohiro (2):
  sparse: Add '__vector_size__' to ignored attributes
  sparse: Add 'error' to ignored attributes

 ident-list.h |    2 ++
 parse.c      |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)

-- 
1.7.8.rc0.dirty
