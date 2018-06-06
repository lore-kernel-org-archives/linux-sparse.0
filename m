From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v5 2/4] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
Date: Wed, 6 Jun 2018 10:01:32 -0400
Message-ID: <20180606100132.772e29a5@vmware.local.home>
References: <1528186420-6615-3-git-send-email-changbin.du@intel.com>
        <201806060444.hdHcKOBy%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201806060444.hdHcKOBy%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: changbin.du@intel.com, kbuild-all@01.org, mingo@redhat.com, akpm@linux-foundation.org, yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, rdunlap@infradead.org, x86@kernel.org, linux@armlinux.org.uk, lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sparse@vger.kernel.org, changbin.du@gmail.com
List-Id: linux-sparse@vger.kernel.org

On Wed, 6 Jun 2018 05:34:29 +0800
kbuild test robot <lkp@intel.com> wrote:

> Hi Changbin,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v4.17 next-20180605]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/changbin-du-intel-com/kernel-hacking-GCC-optimization-for-better-debug-experience-Og/20180606-001415
> config: sparc64-allyesconfig (attached as .config)
> compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=sparc64 
> 
> All warnings (new ones prefixed by >>):
> 
> >> WARNING: vmlinux.o(.text.unlikely+0x1fc): Section mismatch in reference from the function init_tick_ops() to the function .init.text:get_tick_patch()  
>    The function init_tick_ops() references
>    the function __init get_tick_patch().
>    This is often because init_tick_ops lacks a __init
>    annotation or the annotation of get_tick_patch is wrong.

And again this patch uncovered a bug someplace else.

-- Steve

> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
