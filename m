From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Trying to debug strange issue
Date: Fri, 16 Jun 2017 20:50:43 +0100
Message-ID: <CACXZuxc6cQbz7LY=BOHiZLzOFXvEtQnHLrh3J=BUH1PqkJ=8Eg@mail.gmail.com>
References: <CACXZuxd-_hMEpn6TQKNFPjNpYZc8+j0XOS=1bUOjdjZWmQb0Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:34179 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbdFPTup (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 16 Jun 2017 15:50:45 -0400
Received: by mail-wr0-f173.google.com with SMTP id 77so43506679wrb.1
        for <linux-sparse@vger.kernel.org>; Fri, 16 Jun 2017 12:50:44 -0700 (PDT)
In-Reply-To: <CACXZuxd-_hMEpn6TQKNFPjNpYZc8+j0XOS=1bUOjdjZWmQb0Cw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

On 16 June 2017 at 20:20, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> I am trying to implement the ability to compile a string buffer rather
> than a file. So I have created something similar to sparse_file() but
> it takes a buffer instead.
>
> Anyway the issue is that the linearized instructions are coming out
> with 0 size. I was wondering if there is a quick way to locate what is
> going wrong.
>

Turns out I was missing a call to evaluate_symbol_list().

Regards
Dibyendu
