From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v5 2/4] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
Date: Wed, 6 Jun 2018 14:26:22 -0400
Message-ID: <20180606142622.2338abf6@vmware.local.home>
References: <1528186420-6615-3-git-send-email-changbin.du@intel.com>
        <201806060501.btF3aJMZ%fengguang.wu@intel.com>
        <20180606095714.1d3c2def@vmware.local.home>
        <20180606142600.GN13775@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606142600.GN13775@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, kbuild test robot <lkp@intel.com>, linux-arch@vger.kernel.org, michal.lkml@markovi.net, linux-kernel@vger.kernel.org, arnd@arndb.de, yamada.masahiro@socionext.com, lgirdwood@gmail.com, broonie@kernel.org, rdunlap@infradead.org, x86@kernel.org, linux@armlinux.org.uk, changbin.du@intel.com, linux-sparse@vger.kernel.org, mingo@redhat.com, kbuild-all@01.org, akpm@linux-foundation.org, changbin.du@gmail.com, tglx@linutronix.de, linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-sparse@vger.kernel.org

On Wed, 6 Jun 2018 16:26:00 +0200
Johan Hovold <johan@kernel.org> wrote:

> Looks like the greybus code above is working as intended by checking for
> unterminated string after the strncpy, even if this does now triggers
> the truncation warning.

Ah, yes I now see that. Thanks for pointing it out. But perhaps it
should also add the "- 1" to the strncpy() so that gcc doesn't think
it's a mistake.

-- Steve
