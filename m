Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0A4C433F5
	for <linux-sparse@archiver.kernel.org>; Mon, 27 Sep 2021 23:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7085E61178
	for <linux-sparse@archiver.kernel.org>; Mon, 27 Sep 2021 23:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbhI0Xum (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 27 Sep 2021 19:50:42 -0400
Received: from avasout02.plus.net ([212.159.14.17]:40914 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237972AbhI0Xuj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Sep 2021 19:50:39 -0400
Received: from [10.0.2.15] ([147.147.167.109])
        by smtp with ESMTPA
        id V0FTmVriDrasdV0FUmS0rU; Tue, 28 Sep 2021 00:41:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1632786089; bh=w7ww/B42aUcUN8hbtTWBlumvghK12OmK/sPTvlZJXck=;
        h=To:Cc:From:Subject:Date;
        b=lCE2MgTfd/Yb14dKGcDZV6q1GrMCNKV1eA6HvhvgPQ6Bt8p8FR5FokUPa01fYp+5j
         717b/Xv/4C6Opy/zaiS0KvdMDQnNJZ1HWL0Pmt1owCJy+MUKljPleDH4FumYJiq7rh
         n6WG8JpLpfoVvohDS6stMT28NaX7awgQCvgJpDUMKxkRshsHWzD1m3tUKBa17kmoYz
         p/xu+EOVxQ1rrQNi9pzf7qtOag4lOqlAfduWAqLxyb/dbKWZnU32mDjOQd7eMeIxXv
         WSx7gW0gxo2axCn9OXViAhAJN7cSMP0jY4iAeH+aocrvP8fOwK9/+nKDE09uNmOafG
         WvanGEyhQ0xiA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=dIE9ZNRb c=1 sm=1 tr=0
 a=QdS5mZX/VJYKMdXaSBaSIA==:117 a=QdS5mZX/VJYKMdXaSBaSIA==:17
 a=IkcTkHD0fZMA:10 a=dvJSaIg1cAsF2FK1ke8A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 0/2] sparse v0.6.4 regression
Message-ID: <c29182d4-3141-83c6-21f6-d7f368b3d3c5@ramsayjones.plus.com>
Date:   Tue, 28 Sep 2021 00:41:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBrNTOjmqSZUd9Yt+Sflnzg5bMKD0ziRhx8Jlv4ebxkYofmZsXfIR+1Ab162uO+JDEAkAHUSxZ/nqhuoIQ2hWyR8PL/phyJeAYjaNPtCCn82U06Qy3kp
 YjNQoamT72ZsgpAxyaRY/86T0ErpPqf485OasnOvqXVaCPABAGf3m3/oKT9IYY5q1yPeDVNrWZptGA==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org


Hi Luc,

I noticed a regression introduced by commit a69f8d70 which, effectively,
disables the 'memcpy-max-count' check. (I had done a 'make CC=cgcc' in
git, expecting to see some warnings, including the 'memcpy-max-count'
check, and it didn't appear ... :( ). Sorry for not noticing before, but
the 'sparse' make target is supposed to suppress that warning for the
pack-revindex.c file, so ... ;P

[I tried finding your last 'kernel sparse warnings change' list email
to see how many of these warnings still appear in the kernel ... well
it would be zero with v0.6.4!]

I also included the 'case label' patch I sent before, this time with
a commit message and a test. (The test could be extended when sparse
is updated to include the full label-positioning of C23!).

ATB,
Ramsay Jones

Ramsay Jones (2):
  sparse: fix broken 'memcpy-max-count' check
  parse: warn about a 'case label' on empty statement

 parse.c                        |  5 +++++
 sparse.c                       |  2 +-
 validation/byte-count-max.c    | 28 ++++++++++++++++++++++++++++
 validation/label-positioning.c | 22 ++++++++++++++++++++++
 4 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 validation/byte-count-max.c
 create mode 100644 validation/label-positioning.c

-- 
2.33.0
