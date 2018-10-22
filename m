From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 0/2] Compiler Attributes: __fallthrough
Date: Mon, 22 Oct 2018 09:54:27 -0700
Message-ID: <CAKwvOdn9hOcF01eOmwfnrH_ciFZ4fPaspSzMPiY68o3B0En-VQ@mail.gmail.com>
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021182926.GB6683@kroah.com> <CANiq72kOE0a4M0oCmmiWO9xTFJsybEirwUyb_ZTXpJJhc7O_TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANiq72kOE0a4M0oCmmiWO9xTFJsybEirwUyb_ZTXpJJhc7O_TA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, dan.carpenter@oracle.com, adilger.kernel@dilger.ca, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, rostedt@goodmis.org, mchehab+samsung@kernel.org, olof@lxom.net, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, sandipan@linux.vnet.ibm.com, Andrey Konovalov <andreyknvl@google.com>, David Woodhouse <dwmw2@infradead.org>, Will Deacon <will.deacon@arm.com>, Philippe Ombredanne <pombredanne@nexb.com>
List-Id: linux-sparse@vger.kernel.org

On Mon, Oct 22, 2018 at 2:48 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sun, Oct 21, 2018 at 8:29 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > Will this work with all of the static tools that are currently looking
> > for the comment instead?  I know coverity handles that, what about
> > others?
>
> I will also contact the different tools about this.

Let's contact the authors of these tools if they don't parse the
attribute.  I prefer to have the attributes rather than specifically
formatted comments.

I do think this may be tricky to provide backwards support for though;
Miguel, do you have info on which versions of GCC support comments vs
attribute?
-- 
Thanks,
~Nick Desaulniers
