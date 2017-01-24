From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Query regarding sizeof long
Date: Tue, 24 Jan 2017 14:23:13 +0000
Message-ID: <CACXZuxdCP6C_1Y7OHgrxkLYct6CuuArM22ZH6_g_CHixMDhTQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f178.google.com ([209.85.217.178]:35258 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdAXOXO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 24 Jan 2017 09:23:14 -0500
Received: by mail-ua0-f178.google.com with SMTP id y9so135350428uae.2
        for <linux-sparse@vger.kernel.org>; Tue, 24 Jan 2017 06:23:14 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi

I am working on porting Sparse to Windows, and I noticed that in
64-bit architecture the bits_in_long is set to 64. This is not true
for Windows where long is 32 bits on a 64-bit machine. I was wondering
if I just need to set this parameter to 32 or if there are other
implications that I need to be aware of.

Thanks and Regards
Dibyendu
