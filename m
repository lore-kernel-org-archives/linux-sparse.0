From: Christopher Li <sparse@chrisli.org>
Subject: Re: Sparse documentation format, rST vs MD
Date: Mon, 7 Aug 2017 19:45:58 -0400
Message-ID: <CANeU7QnXJo98x=vO-5iBQgKX4YOAbqEfqV+jmSmbBb1b=AV0eQ@mail.gmail.com>
References: <CANeU7QkbNzGVVGbvMdaN14g2nPnF3ha6+mBkLJfhCFvf90cy_w@mail.gmail.com>
 <20170807045611.aq3ofd57a7mtvdcm@x> <20170807102532.547fc0e2@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:38891 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751881AbdHGXp7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 19:45:59 -0400
Received: by mail-pg0-f54.google.com with SMTP id l64so7338907pge.5
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 16:45:59 -0700 (PDT)
In-Reply-To: <20170807102532.547fc0e2@lwn.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: Josh Triplett <josh@joshtriplett.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Mon, Aug 7, 2017 at 12:25 PM, Jonathan Corbet <corbet@lwn.net> wrote:
> To address the "why the kernel picked RST" question, in case anybody's
> curious...

Thanks for the explain that is interesting read.

>  - It allows the creation of large, integrated, multi-file documents.
>    Every MD file is a world unto itself, and AsciiDoc is about the same.
>    RST lets us put in nice things like global indexes and cross-references.

That is useful. MD do allow cross reference like html links but I don't know
about global indexes.

Chris
