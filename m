From: Ben Dooks <ben-linux@fluff.org>
Subject: sparse 0.4.1 and __cold__
Date: Sun, 14 Sep 2008 15:31:52 +0100
Message-ID: <20080914143152.GI322@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.145.97.151]:52195 "EHLO
	trinity.fluff.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754051AbYINObx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 14 Sep 2008 10:31:53 -0400
Received: from ben by trinity.fluff.org with local (Exim 4.50)
	id 1Kesdk-0005Gy-7C
	for linux-sparse@vger.kernel.org; Sun, 14 Sep 2008 15:31:52 +0100
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

I've just been trying sparse 0.4.1 with linux-next and have noticed
that the discussions and patches wrt to the __cold__ attribute have
not yet made it into a release version.

Would it be possible to put a release of sparse up which handled
this attribute please?

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
