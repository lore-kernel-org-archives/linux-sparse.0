From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 0/2] Compiler Attributes: __fallthrough
Date: Mon, 22 Oct 2018 08:27:01 +0300
Message-ID: <20181022052700.a6v3d6t43kot6yso@mwanda>
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021182926.GB6683@kroah.com>
 <d56762f8856201f520a3ee5553276621237e8e27.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d56762f8856201f520a3ee5553276621237e8e27.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, linux-kernel@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Steven Rostedt <rostedt@goodmis.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Olof Johansson <olof@lxom.net>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, "David S . Miller" <davem@davemloft.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Sandipan Das <sandipan@linux.vnet.ibm.com>, Andrey Konovalov <andreyknvl@google.com>
List-Id: linux-sparse@vger.kernel.org

On Sun, Oct 21, 2018 at 11:52:21AM -0700, Joe Perches wrote:
> On Sun, 2018-10-21 at 19:29 +0100, Greg Kroah-Hartman wrote:i
> > On Sun, Oct 21, 2018 at 07:14:12PM +0200, Miguel Ojeda wrote:
> > > These are two patches are meant to go on top of the rest of the compiler
> > > attributes series on:
> > > 
> > >   https://github.com/ojeda/linux/tree/compiler-attributes
> > > 
> > > which will be sent to Greg for the next merge window.
> > > 
> > > Please review them and let me know! (specially if someone is against
> > > __fallthrough for some reason :-).
> > 
> > Will this work with all of the static tools that are currently looking
> > for the comment instead?
> 
> Does anyone have a list of the static tools that
> use comment style fallthrough notations?
> 

It would only be CPPcheck I think.

regards,
dan carpenter
