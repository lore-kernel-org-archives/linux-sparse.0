From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 06/29] topasm: top-level asm is special
Date: Thu, 17 Aug 2017 02:49:51 -0400
Message-ID: <CANeU7QkxQJ7aWiduHT1anBAU+_rhgjwbfXi+wVjXE=ib9hW-0A@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com> <20170816153455.97693-7-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:36288 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751620AbdHQGtw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 02:49:52 -0400
Received: by mail-yw0-f175.google.com with SMTP id u207so35763711ywc.3
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 23:49:52 -0700 (PDT)
In-Reply-To: <20170816153455.97693-7-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Aug 16, 2017 at 11:34 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
>
> +       if (!sym->ident) {      // top-level asm

Maybe here we should check the statement is really top-level asm?
Later on we might have more than top-level asm as with sym->ident == NULL.

Chris
