From: Shakthi Kannan <shakthimaan@gmail.com>
Subject: Using c2xml on kernel sources
Date: Tue, 20 Mar 2012 14:30:18 +0530
Message-ID: <CABG-yt06Kw2uFnmrshcHYjgf_cMgzKVdMPe6BXOP2nryhRjBpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36569 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965094Ab2CTJAU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 20 Mar 2012 05:00:20 -0400
Received: by wibhq7 with SMTP id hq7so4912984wib.1
        for <linux-sparse@vger.kernel.org>; Tue, 20 Mar 2012 02:00:19 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

I would like to run c2xml on the Linux kernel sources. Is there a
recommended way of using the tool on kernel code?

I tried running it directly on a source file, but, get the
'header-file "unable to open" error.

  $ c2xml linux-3.0.4/net/ethernet/eth.c

  ../linux-3.0.4/net/ethernet/eth.c:40:11: error: unable to open
'linux/module.h'

I have built sparse from git sources (v0.4.4) on Fedora 15 x86_64.

Appreciate any inputs in this regard.

Thanks!

SK

-- 
Shakthi Kannan
http://www.shakthimaan.com
