From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Interaction between bitfields and casts
Date: Wed, 9 Aug 2017 21:41:36 +0100
Message-ID: <CACXZuxfUC1DostLzrB2nk9eOvDox1oxG-HjHm+nrWqtyRWEGVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:35519 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752113AbdHIUli (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 16:41:38 -0400
Received: by mail-vk0-f43.google.com with SMTP id d124so30089365vkf.2
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 13:41:37 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

When assigning values to bitfields I have noticed that some times
Sparse generates a CAST instruction with an odd bit size - i.e. not a
standard integer size. I was wondering if there are specific scenarios
that lead to this. While LLVM handles the odd cast - I am working with
another backend (Nanojit) that doesn't.

Regards
Dibyendu
