From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] Compiler Attributes: __fallthrough
Date: Sun, 21 Oct 2018 19:29:26 +0100
Message-ID: <20181021182926.GB6683@kroah.com>
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Steven Rostedt <rostedt@goodmis.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Olof Johansson <olof@lxom.net>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, "David S . Miller" <davem@davemloft.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Sandipan Das <sandipan@linux.vnet.ibm.com>, Andrey Konovalov <andreyknvl@google.com>, David Woodhouse <dwmw2@infradead.org>, Will Deacon <wi>
List-Id: linux-sparse@vger.kernel.org

On Sun, Oct 21, 2018 at 07:14:12PM +0200, Miguel Ojeda wrote:
> These are two patches are meant to go on top of the rest of the compiler
> attributes series on:
> 
>   https://github.com/ojeda/linux/tree/compiler-attributes
> 
> which will be sent to Greg for the next merge window.
> 
> Please review them and let me know! (specially if someone is against
> __fallthrough for some reason :-).

Will this work with all of the static tools that are currently looking
for the comment instead?  I know coverity handles that, what about
others?

thanks,

greg k-h
