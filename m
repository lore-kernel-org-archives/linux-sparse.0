From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v5 2/4] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
Date: Thu, 7 Jun 2018 10:06:37 +0200
Message-ID: <20180607080637.GQ13775@localhost>
References: <1528186420-6615-3-git-send-email-changbin.du@intel.com>
 <201806060501.btF3aJMZ%fengguang.wu@intel.com>
 <20180606095714.1d3c2def@vmware.local.home>
 <20180606142600.GN13775@localhost>
 <20180606142622.2338abf6@vmware.local.home>
 <20180607041718.qpqucjzlvcm5h3gn@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180607041718.qpqucjzlvcm5h3gn@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, gregkh@linuxfoundation.org, alex.elder@linaro.org, Johan Hovold <johan@kernel.org>, kbuild test robot <lkp@intel.com>, linux-arch@vger.kernel.org, michal.lkml@markovi.net, linux-kernel@vger.kernel.org, arnd@arndb.de, yamada.masahiro@socionext.com, lgirdwood@gmail.com, broonie@kernel.org, rdunlap@infradead.org, x86@kernel.org, linux@armlinux.org.uk, changbin.du@intel.com, linux-sparse@vger.kernel.org, mingo@redhat.com, kbuild-all@01.org, akpm@linux-foundation.org, changbin.du@gmail.com, tglx@linutronix.de, linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-sparse@vger.kernel.org

On Thu, Jun 07, 2018 at 09:47:18AM +0530, Viresh Kumar wrote:

> On 06-06-18, 14:26, Steven Rostedt wrote:
> > On Wed, 6 Jun 2018 16:26:00 +0200
> > Johan Hovold <johan@kernel.org> wrote:
> > 
> > > Looks like the greybus code above is working as intended by checking for
> > > unterminated string after the strncpy, even if this does now triggers
> > > the truncation warning.
> 
> So why exactly are we generating a warning here ? Is it because it is possible
> that the first n bytes of src may not have the null terminating byte and the
> dest may not be null terminated eventually ?

Yes, new warning in GCC 8:

	https://gcc.gnu.org/onlinedocs/gcc-8.1.0/gcc/Warning-Options.html#index-Wstringop-truncation

> Maybe I should just use memcpy here then ?

No, as you note below, you use strncpy to clear the rest of the buffer.

> But AFAIR, I used strncpy() specifically because it also sets all the remaining
> bytes after the null terminating byte with the null terminating byte. And so it
> is pretty easy for me to check if the final string is null terminated by
> checking [max - 1] byte against '\0', which the code is doing right now.
> 
> I am not sure what would the best way to get around this incorrect-warning.

It seems gcc just isn't smart enough in this case (where you check for
overflow and never use a non-terminated string), but it is supposed to
detect when the string is unconditionally terminated. So perhaps just
adding a redundant buf[size-1] = '\0' before returning in the error path
or after the error path would shut it up. But that's a bit of a long
shot, I admit.

Probably best to leave things as they are, and let the gcc folks find a
way to handle such false positives.

Thanks,
Johan
