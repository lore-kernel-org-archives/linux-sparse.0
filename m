From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 1/2] Compiler Attributes: add support for __fallthrough
 (gcc >= 7.1)
Date: Mon, 22 Oct 2018 02:58:00 -0400
Message-ID: <20181022065800.GK1617@thunk.org>
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com>
 <20181022004217.GA4941@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181022004217.GA4941@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Steven Rostedt <rostedt@goodmis.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Olof Johansson <olof@lxom.net>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, "David S . Miller" <davem@davemloft.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Sandipan Das <sandipan@linux.vnet.ibm.com>
List-Id: linux-sparse@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 21, 2018 at 05:42:18PM -0700, Matthew Wilcox wrote:
> On Sun, Oct 21, 2018 at 07:14:13PM +0200, Miguel Ojeda wrote:
> > +#if __has_attribute(__fallthrough__)
> > +# define __fallthrough                  __attribute__((__fallthrough__))
> > +#else
> > +# define __fallthrough
> > +#endif
> 
> Why is the #else not:
> 
> # define __fallthrough		/* fallthrough */
> 
> Would this solve the Coverity problem, or does Coverity look at the raw
> source code before preprocessing?

Wouldn't the "/* ... */" be eaten by the preprocessor before defining
the __fallthrough cpp macro?  (e.g., try running the attached script)

						- Ted




--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=foo

#!/bin/bash

cat << EOF > /tmp/test$$.c
#define foobar quux /* foobar */

foobar
EOF
gcc -E /tmp/test$$.c
rm -f /tmp/test$$.c

--ikeVEW9yuYc//A+q--
