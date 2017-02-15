From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/4] assorted cleanups
Date: Wed, 15 Feb 2017 23:13:54 +0100
Message-ID: <20170215221358.68400-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34700 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752515AbdBOWOM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Feb 2017 17:14:12 -0500
Received: by mail-wr0-f196.google.com with SMTP id c4so7320932wrd.1
        for <linux-sparse@vger.kernel.org>; Wed, 15 Feb 2017 14:14:11 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This serie is only a small collections of independent
cleanups, mainly removal of unused struct members.

Patches 1-4 have no functional changes.
Patch 4 make show_statement() slightly more useful.


*** BLURB HERE ***

Luc Van Oostenryck (4):
  cleanup: there is no 'struct phi' to allocate
  remove unused field 'multijmp' in struct statement
  remove unused field 'goto_bb' in struct statement
  fix show-parse()'s labels

 allocate.h   | 1 -
 parse.h      | 9 ---------
 show-parse.c | 6 +++---
 3 files changed, 3 insertions(+), 13 deletions(-)

-- 
2.11.0

