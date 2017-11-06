From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] make builtins more built-in
Date: Mon,  6 Nov 2017 21:16:26 +0100
Message-ID: <20171106201628.98470-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51817 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932452AbdKFUSk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Nov 2017 15:18:40 -0500
Received: by mail-wm0-f66.google.com with SMTP id b9so16801965wmh.0
        for <linux-sparse@vger.kernel.org>; Mon, 06 Nov 2017 12:18:40 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to avoid the texual declaration of
builtin functions, followed by their tokenization and parsing.
This is unneeded work done at startup.
The patches in this series, directly declare the symbol/type
corresponding to these functions.


Luc Van Oostenryck (2):
  builtin: add ctype for const {void,char} *
  builtin: make builtins more builtin

 builtin.c | 165 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib.c     | 157 ++---------------------------------------------------------
 symbol.c  |   4 ++
 symbol.h  |   2 +
 4 files changed, 176 insertions(+), 152 deletions(-)

-- 
2.14.0

