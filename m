From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] cleanup show OP_SYMADDR/PSEUDO_SYM
Date: Wed, 14 Feb 2018 01:28:02 +0100
Message-ID: <20180214002804.22668-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:50990 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966183AbeBNA2L (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 19:28:11 -0500
Received: by mail-wm0-f45.google.com with SMTP id k87so1480722wmi.0
        for <linux-sparse@vger.kernel.org>; Tue, 13 Feb 2018 16:28:11 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series contains small cleanups for displaying a symbol,
either for OP_SYMADDR or PSUDO_SYM.
More importantly it also contains a fix against crashes
occuring when trying to display an OP_SYMADDR of an
invalid symbol.

Luc Van Oostenryck (2):
  show_pseudo(): protect against NULL ->sym
  use show_pseudo() for OP_SYMADDR's symbol

 linearize.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

-- 
2.16.0

