From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Sparse parsing question: symbols in parse tree
Date: Sun, 20 Aug 2017 22:51:20 +0100
Message-ID: <CACXZuxctG4_rqA0v2KNmxNvK693wH8EMVGhCjPEcHisiKUdUBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:34197 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753300AbdHTVvV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Aug 2017 17:51:21 -0400
Received: by mail-vk0-f46.google.com with SMTP id n125so45350062vke.1
        for <linux-sparse@vger.kernel.org>; Sun, 20 Aug 2017 14:51:21 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

Whenever an EXPR_SYMBOL is encountered does this actually equate to
the address of the symbol?

Regards
Dibyendu
