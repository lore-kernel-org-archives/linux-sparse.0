From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/9] Simplify the parsion of options
Date: Fri, 15 Sep 2017 09:32:14 +0200
Message-ID: <20170915073223.7568-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36931 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbdIOHca (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:32:30 -0400
Received: by mail-wm0-f67.google.com with SMTP id f4so1990009wmh.4
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:32:29 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to simplify & unify the parsing of
options given on the command line

In itself, it hasn't much value but is used by some upcoming series.


The series is also available for review in the git repository at:

  git://github.com/lucvoo/sparse.git option-parsing

----------------------------------------------------------------
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
