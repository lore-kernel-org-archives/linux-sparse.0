From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 0/2] Compiler Attributes: __fallthrough
Date: Tue, 23 Oct 2018 08:43:06 +0300
Message-ID: <20181023054306.wbmcg6vigc4jlb25@mwanda>
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021182926.GB6683@kroah.com>
 <CANiq72kOE0a4M0oCmmiWO9xTFJsybEirwUyb_ZTXpJJhc7O_TA@mail.gmail.com>
 <CAKwvOdn9hOcF01eOmwfnrH_ciFZ4fPaspSzMPiY68o3B0En-VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKwvOdn9hOcF01eOmwfnrH_ciFZ4fPaspSzMPiY68o3B0En-VQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, adilger.kernel@dilger.ca, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, rostedt@goodmis.org, mchehab+samsung@kernel.org, olof@lxom.net, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, sandipan@linux.vnet.ibm.com, Andrey Konovalov <andreyknvl@google.com>, David Woodhouse <dwmw2@infradead.org>, Will Deacon <will.deacon@arm.com>, Philippe Ombredanne <pombred>
List-Id: linux-sparse@vger.kernel.org

On Mon, Oct 22, 2018 at 09:54:27AM -0700, Nick Desaulniers wrote:
> On Mon, Oct 22, 2018 at 2:48 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > On Sun, Oct 21, 2018 at 8:29 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > Will this work with all of the static tools that are currently looking
> > > for the comment instead?  I know coverity handles that, what about
> > > others?
> >
> > I will also contact the different tools about this.
> 
> Let's contact the authors of these tools if they don't parse the
> attribute.  I prefer to have the attributes rather than specifically
> formatted comments.
> 
> I do think this may be tricky to provide backwards support for though;
> Miguel, do you have info on which versions of GCC support comments vs
> attribute?

None.  GCC 7.1 added support for the warning, the comment parsing and
the attribute so it's fine.

The only thing that we know for sure is an issue is Eclipse.

We need to test Coverity but it should work in theory.  And we don't
know about CPPcheck.

regards,
dan carpenter
