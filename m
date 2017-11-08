From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/9] option parsing improvements
Date: Wed,  8 Nov 2017 11:09:59 +0100
Message-ID: <20171108101008.43804-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:48530 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbdKHKKT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Nov 2017 05:10:19 -0500
Received: by mail-wr0-f195.google.com with SMTP id 15so1896964wrb.5
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 02:10:18 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to make the parsing of sparse's
option more flexible.
Its real value is really apparent in subsequent series.

Luc Van Oostenryck (9):
  option: add helper to parse/match command line options
  option: rename 'struct warning' to 'struct flag'
  option: let handle_simple_switch() handle an array of flags
  option: extract OPTION_NUMERIC() from handle_switch_fmemcpy_max_count()
  option: add support for options with 'zero is infinity'
  option: add support for '-<some-option>=unlimited'
  option: use OPTION_NUMERIC() for handle_switch_fmemcpy_max_count()
  option: constify match_option()
  option: handle switches by table

 lib.c    | 162 ++++++++++++++++++++++++++++++++++++++-------------------------
 sparse.1 |   2 +-
 2 files changed, 100 insertions(+), 64 deletions(-)

-- 
2.14.0

