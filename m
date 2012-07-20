From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: sparse-llvm segfaults when passing a struct pointer
Date: Fri, 20 Jul 2012 13:12:51 -0700
Message-ID: <CA+55aFx9nhVkD7oEKR2SRjVomf4a-WV7tb69PfRJzWkMgfzhyg@mail.gmail.com>
References: <20120719131725.GA2836@debian.debian> <CAOJsxLEuR5mfDr-1RrNXzL7S5stb-79Ez4dx2+7Qbr8fBL+WPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:53660 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985Ab2GTUNN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 20 Jul 2012 16:13:13 -0400
Received: by wgbdr13 with SMTP id dr13so3988816wgb.1
        for <linux-sparse@vger.kernel.org>; Fri, 20 Jul 2012 13:13:12 -0700 (PDT)
In-Reply-To: <CAOJsxLEuR5mfDr-1RrNXzL7S5stb-79Ez4dx2+7Qbr8fBL+WPg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: =?ISO-8859-1?Q?Jonathan_Neusch=E4fer?= <j.neuschaefer@gmx.net>, linux-sparse@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Christopher Li <sparse@chrisli.org>

On Fri, Jul 20, 2012 at 1:21 AM, Pekka Enberg <penberg@kernel.org> wrote:
>
> Linus, Jeff, how does the sparse frontend deal with externs? Why isn't
> "foop" visible after linearize_symbol()?

'extern' symbols are just names with types. They don't have any value
associated with them, they just have the type and the name.

What else would you expect sparse to have?

              Linus
