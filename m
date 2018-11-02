From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 2/2] Compiler Attributes: auxdisplay: panel: use __fallthrough
Date: Fri, 2 Nov 2018 11:49:26 +0100
Message-ID: <CANiq72nrd70qTxEAfxxuNHNoi19MBo=yrJnm9_EnfrpEMQHXCg@mail.gmail.com>
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-3-miguel.ojeda.sandonis@gmail.com> <CAGXu5j+3pR2mfcdbURv7MrPxUVjmjQEDRHH8BLpTNGiasJs1pg@mail.gmail.com>
 <20181023053542.lsklua2p3lnbkqir@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181023053542.lsklua2p3lnbkqir@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan <dan.carpenter@oracle.com>
Cc: Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Greg KH <gregkh@linuxfoundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Andreas Dilger <adilger.kernel@dilger.ca>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Steven Rostedt <rostedt@goodmis.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Olof Johansson <olof@lxom.net>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, David Miller <davem@davemloft.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Sandipan Das <sandipan@linux.vnet.ibm.com>, Andrey Konovalov <andreyknvl@google.com>D
List-Id: linux-sparse@vger.kernel.org

Hi Dan,

On Tue, Oct 23, 2018 at 7:37 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Mon, Oct 22, 2018 at 07:10:02AM -0700, Kees Cook wrote:
> > I would prefer we continue to use the comment style until we've got
> > confirmed support for (at least) Clang, Coverity, CPPcheck, smatch,
> > and eclipse.
>
> Clang and Smatch don't support fall throught comments.  Coverity
> supports both.  CPPcheck is unknown.
>
> Eclipse doesn't support attributes.  So it's just Eclipse and maybe
> CPP check.

Thanks for checking! Let's wait then a few months and see if we can
get cppcheck/Eclipse to support it.

Cheers,
Miguel
