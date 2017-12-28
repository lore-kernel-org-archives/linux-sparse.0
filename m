From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] llvm: improve default/zero initialization
Date: Thu, 28 Dec 2017 23:30:24 +0100
Message-ID: <20171228223026.39089-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33514 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbdL1Waq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 28 Dec 2017 17:30:46 -0500
Received: by mail-wm0-f65.google.com with SMTP id g130so3390213wme.0
        for <linux-sparse@vger.kernel.org>; Thu, 28 Dec 2017 14:30:46 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series contains:
- a fix for the default initialization of arrays and structures
- a small simplification for the initialization of null-pointers

This series is available in the Git repository at:
  git://github.com/lucvoo/sparse-dev.git llvm-zero-init

Luc Van Oostenryck (2):
  llvm: simplify emit of null pointers
  llvm: default init of arrays & structs

 sparse-llvm.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

-- 
2.15.0

