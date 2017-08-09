From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Interaction between bitfields and casts
Date: Wed, 9 Aug 2017 23:10:01 +0200
Message-ID: <CAMHZB6HbGqheOpd1PyrQEiJs4rwrnFTnJDeP8EWRJLdiuYoGmA@mail.gmail.com>
References: <CACXZuxfUC1DostLzrB2nk9eOvDox1oxG-HjHm+nrWqtyRWEGVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:33068 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbdHIVKC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 17:10:02 -0400
Received: by mail-qt0-f175.google.com with SMTP id a18so44138273qta.0
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 14:10:02 -0700 (PDT)
In-Reply-To: <CACXZuxfUC1DostLzrB2nk9eOvDox1oxG-HjHm+nrWqtyRWEGVQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Aug 9, 2017 at 10:41 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi,
>
> When assigning values to bitfields I have noticed that some times
> Sparse generates a CAST instruction with an odd bit size - i.e. not a
> standard integer size. I was wondering if there are specific scenarios
> that lead to this. While LLVM handles the odd cast - I am working with
> another backend (Nanojit) that doesn't.

Yes, I know. There is already one less with:
    [PATCH v4 5/9] change the masking when loading bitfields"

Otherwise, it's really a question of translating then into the right
instruction(s) to truncate/zero extend/sign extend part of a word
(but the casts instructions in sparse's IR are a bit strange and
need special care when the src or the dest is not an integer but
a float or a pointer).

I have an unfinished series that clean this a bit but
it will be after the currently pending series.

-- Luc
