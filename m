From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/6] keyword cleanup
Date: Fri,  5 May 2017 03:50:28 +0200
Message-ID: <20170505015034.65164-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35622 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbdEEBum (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 4 May 2017 21:50:42 -0400
Received: by mail-wr0-f195.google.com with SMTP id g12so2990103wrg.2
        for <linux-sparse@vger.kernel.org>; Thu, 04 May 2017 18:50:41 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The recent patch "add support for _Static_assert" triggered
some spring cleanup of the "ident-list.h" file.
The changes in this series are mainly moving around some
definitions and removing unneeded ones.

The patches are to be applied on top of the '_Static_assert' patch.

Luc Van Oostenryck (6):
  keyword: add test case for reserved '_Static_assert'
  keyword: regroup the [reserved] keywords
  keyword: explicitly add C99 & C11 keywords
  keyword: add more reserved keywords to the test case
  keyword: add a comment about NS_TYPEDEF & reserved keywords
  keyword: no pre-declaration needed for attribute names

 ident-list.h          |  78 ++++++-----------------
 parse.c               |   1 +
 validation/reserved.c | 171 ++++++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 163 insertions(+), 87 deletions(-)


The series can also be found at:
  git://github.com/lucvoo/sparse.git keyword-cleanup
based on commit a04a3b0acdaa0d95bba30a12e691804e13ef8166:
  sparse: add support for _Static_assert
up to commit 467aed81354b5a404a7c6c47aa38a2c6bfe08b8f:
  keyword: no pre-declaration needed for attribute names

-- Luc Van Oostenryck
