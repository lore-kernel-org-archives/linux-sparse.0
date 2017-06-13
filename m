From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: c2xml uses out of type modifiers mapping
Date: Tue, 13 Jun 2017 23:02:49 +0100
Message-ID: <CACXZuxeVo=5Lz2idvtbeHjLJHLZ4gPissRVfCyDAsKw1mKPRTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:35862 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752452AbdFMWCv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Jun 2017 18:02:51 -0400
Received: by mail-wr0-f172.google.com with SMTP id 36so41133614wry.3
        for <linux-sparse@vger.kernel.org>; Tue, 13 Jun 2017 15:02:51 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I noticed that the mapping for type modifiers in c2xml is out of sync
with the MOD_* definitions in symbol.h.

Regards
Dibyendu
