From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Sparse parsing question - iterator statements
Date: Tue, 22 Aug 2017 14:59:06 +0100
Message-ID: <CACXZuxfWQHzHs1gps6SPPKvX53HUwVfEeca=sJPatKg39GF-8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:36513 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932874AbdHVN7H (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 22 Aug 2017 09:59:07 -0400
Received: by mail-vk0-f47.google.com with SMTP id u133so59462766vke.3
        for <linux-sparse@vger.kernel.org>; Tue, 22 Aug 2017 06:59:07 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I am trying to understand the way the iterator statement works. I
think if I understand this correctly then there are some implicit
jumps on pre-condition and post-condition - similar to the implicit
jumps in if statements. What I mean by that is that the parse tree
does not model these jumps with explicit gotos.

Regards
Dibyendu
