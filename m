From: Christopher Li <sparse@chrisli.org>
Subject: Re: Sparse parsing question: string literal
Date: Sun, 20 Aug 2017 09:31:44 -0400
Message-ID: <CANeU7QnD4g77njKBPjGtxjgfrVfZ8bZz5XLuv9sForxtjdaHXA@mail.gmail.com>
References: <CACXZuxcvbCc+eOyqzrUUs4qkTpS705u065nc5=H8DLJ9AQnCEw@mail.gmail.com>
 <CANeU7Qkq60MA_ufvPsx6dXvr5ZW-kVaGmwVVQ8gQY1g=srZ1MA@mail.gmail.com> <CACXZuxd755Q2FK4Br36nVyMjatiQGLjhKAhWS05Erm1X=bt1XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:32809 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752866AbdHTNbp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Aug 2017 09:31:45 -0400
Received: by mail-yw0-f169.google.com with SMTP id h127so11017248ywf.0
        for <linux-sparse@vger.kernel.org>; Sun, 20 Aug 2017 06:31:45 -0700 (PDT)
In-Reply-To: <CACXZuxd755Q2FK4Br36nVyMjatiQGLjhKAhWS05Erm1X=bt1XA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 20, 2017 at 9:12 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> I see - so every string literal results in an un-named symbol, whose
> initializer is set to the string expression?

Yes, because you can do sizeof("hello"). The string literal need to have type
and size. That is why it is wrap in a symbol of char array.  It can have a
proper size. Int and float constant has fix size and type, they can be
represented
directly in expression.

Chris
