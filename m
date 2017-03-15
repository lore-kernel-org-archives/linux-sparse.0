From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm incorrect check for floating point type
Date: Wed, 15 Mar 2017 00:40:21 +0000
Message-ID: <CACXZuxd6DsWh7i=+ETza_AOhWTdgF9b28cwmp+3G-0GsVsBJwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:34683 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbdCOAkX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 14 Mar 2017 20:40:23 -0400
Received: by mail-io0-f181.google.com with SMTP id b140so10806912iof.1
        for <linux-sparse@vger.kernel.org>; Tue, 14 Mar 2017 17:40:22 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

The function symbol_is_fp_type() in sparse-llvm.c doesn't check if
symbol is SYM_NODE and hence does not detect a floating point type
correctly.

Regards
Dibyendu
