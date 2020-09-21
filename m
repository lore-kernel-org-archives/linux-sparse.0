Return-Path: <SRS0=IWWX=C6=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D38C43464
	for <linux-sparse@archiver.kernel.org>; Mon, 21 Sep 2020 08:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35FB42076E
	for <linux-sparse@archiver.kernel.org>; Mon, 21 Sep 2020 08:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgIUIR1 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 21 Sep 2020 04:17:27 -0400
Received: from mailout11.rmx.de ([94.199.88.76]:50084 "EHLO mailout11.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbgIUIR1 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 21 Sep 2020 04:17:27 -0400
X-Greylist: delayed 1999 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 04:17:26 EDT
Received: from kdin01.retarus.com (kdin01.dmz1.retloc [172.19.17.48])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout11.rmx.de (Postfix) with ESMTPS id 4BvxK04jL5z3yPR
        for <linux-sparse@vger.kernel.org>; Mon, 21 Sep 2020 09:44:04 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin01.retarus.com (Postfix) with ESMTPS id 4BvxJx6yb5z2xbK
        for <linux-sparse@vger.kernel.org>; Mon, 21 Sep 2020 09:44:01 +0200 (CEST)
Received: from n95hx1g2.localnet (192.168.54.119) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 21 Sep
 2020 09:44:01 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
CC:     <linux-sparse@vger.kernel.org>
Subject: Re: Segmentation fault when running sparse with current linux master
Date:   Mon, 21 Sep 2020 09:44:00 +0200
Message-ID: <4184357.m9dUj1Odhv@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20200917142017.5fhdjdfrwjyjqlpu@ltop.local>
References: <1832426.vqaiCtIcaR@n95hx1g2> <20200917142017.5fhdjdfrwjyjqlpu@ltop.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.119]
X-RMX-ID: 20200921-094401-4BvxJx6yb5z2xbK-0@kdin01
X-RMX-SOURCE: 217.111.95.66
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hi Luc,

On Thursday, 17 September 2020, 16:20:17 CEST, Luc Van Oostenryck wrote:
> On Thu, Sep 17, 2020 at 01:08:57PM +0200, Christian Eggers wrote:
> > Build of the current linux kernel breaks on my system due to segmentation
> > fault when running sparse.
> > 
> > Sparse version: 0.6.2 (built by openSUSE build service)
> 
> Hi,
> 
> This has already been reported and fixed in the main tree in late July.
> It's not clear to me if the latest OpenSUSE packages for sparse contain
> or not the needed fix.
> 
> Can you try the version compiled from the source? It's super-easy:
> 	cd $dir
> 	git clone git://git.kernel.org/pub/scm/devel/sparse/sparse.git
> 	cd sparse
> 	make
> 	cp sparse ~/bin/
> 

I fetched the source RPM from openSUSE and replaced the 0.6.2 tar.xz with the 
current master. After building an updating the RPM, sparse doesn't crash 
anymore.

openSUSE ships two versions of sparse [1]:
- official release: 20180324
- experimental: 0.6.2

It seems that both version are affected from this problem. The "experimental" 
version should be automatically updated after a new version of sparse is 
released. The "official release" will probably only accept patches resolving 
specific problems. If you can provide a patch against 20180324, I would try to 
write a bug report against the openSUSE package. This could save some time for 
the next person stumbling over this problem... If you provide the commit id, 
openSUSE can also decide themself whether to fix or upgrade the current 
version.

Best regards
Christian

[1] https://software.opensuse.org/package/sparse



