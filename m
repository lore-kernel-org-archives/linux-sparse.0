From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] small cleanup for sparse-llvm.c
Date: Wed, 14 Feb 2018 00:52:07 +0100
Message-ID: <20180213235209.21615-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42589 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966125AbeBMXyY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 18:54:24 -0500
Received: by mail-wr0-f196.google.com with SMTP id k9so6494251wre.9
        for <linux-sparse@vger.kernel.org>; Tue, 13 Feb 2018 15:54:23 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series contains a small cleanup of sparse-llvm.c,
mostly using symbol_list_size() instead of using and
open-coded loop & count one-by-one.

Luc Van Oostenryck (2):
  llvm: use list_size() to count the numbers of arguments
  llvm: initialize at declaration time

 sparse-llvm.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

-- 
2.16.0

