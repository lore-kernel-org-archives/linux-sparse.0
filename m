From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v5 2/4] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
Date: Wed, 6 Jun 2018 16:26:00 +0200
Message-ID: <20180606142600.GN13775@localhost>
References: <1528186420-6615-3-git-send-email-changbin.du@intel.com>
 <201806060501.btF3aJMZ%fengguang.wu@intel.com>
 <20180606095714.1d3c2def@vmware.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180606095714.1d3c2def@vmware.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: kbuild test robot <lkp@intel.com>, linux-arch@vger.kernel.org, michal.lkml@markovi.net, linux-kernel@vger.kernel.org, arnd@arndb.de, yamada.masahiro@socionext.com, lgirdwood@gmail.com, broonie@kernel.org, rdunlap@infradead.org, x86@kernel.org, linux@armlinux.org.uk, changbin.du@intel.com, linux-sparse@vger.kernel.org, mingo@redhat.com, kbuild-all@01.org, akpm@linux-foundation.org, changbin.du@gmail.com, tglx@linutronix.de, linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-sparse@vger.kernel.org

On Wed, Jun 06, 2018 at 09:57:14AM -0400, Steven Rostedt wrote:
> On Wed, 6 Jun 2018 05:21:55 +0800
> kbuild test robot <lkp@intel.com> wrote:
> 
> > Hi Changbin,
> > 
> > Thank you for the patch! Perhaps something to improve:
> > 
> > [auto build test WARNING on linus/master]
> > [also build test WARNING on v4.17 next-20180605]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> > 
> > url:    https://github.com/0day-ci/linux/commits/changbin-du-intel-com/kernel-hacking-GCC-optimization-for-better-debug-experience-Og/20180606-001415
> > config: ia64-allmodconfig (attached as .config)
> > compiler: ia64-linux-gcc (GCC) 8.1.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         make.cross ARCH=ia64 
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    drivers//staging/greybus/fw-management.c: In function 'fw_mgmt_load_and_validate_operation':
> > >> drivers//staging/greybus/fw-management.c:153:2: warning: 'strncpy' specified bound 10 equals destination size [-Wstringop-truncation]  
> >      strncpy(request.firmware_tag, tag, GB_FIRMWARE_TAG_MAX_SIZE);
> >      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    drivers//staging/greybus/fw-management.c: In function 'fw_mgmt_backend_fw_update_operation':
> >    drivers//staging/greybus/fw-management.c:304:2: warning: 'strncpy' specified bound 10 equals destination size [-Wstringop-truncation]
> >      strncpy(request.firmware_tag, tag, GB_FIRMWARE_TAG_MAX_SIZE);
> >      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > --
> >    drivers/auxdisplay/panel.c: In function 'panel_bind_key':
> > >> drivers/auxdisplay/panel.c:1509:2: warning: 'strncpy' specified bound 12 equals destination size [-Wstringop-truncation]  
> >      strncpy(key->u.kbd.press_str, press, sizeof(key->u.kbd.press_str));
> >      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    drivers/auxdisplay/panel.c:1510:2: warning: 'strncpy' specified bound 12 equals destination size [-Wstringop-truncation]
> >      strncpy(key->u.kbd.repeat_str, repeat, sizeof(key->u.kbd.repeat_str));
> >      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Nice! This patch actually caused bugs in other areas of the code to be
> caught by the build system.
> 
> The patch is not wrong. The code that has these warnings are.

Looks like the greybus code above is working as intended by checking for
unterminated string after the strncpy, even if this does now triggers
the truncation warning.

drivers/auxdisplay/panel.c looks broken, though.

> > vim +/strncpy +153 drivers//staging/greybus/fw-management.c
> > 
> > 013e6653 Viresh Kumar 2016-05-14  138  
> > 013e6653 Viresh Kumar 2016-05-14  139  static int fw_mgmt_load_and_validate_operation(struct fw_mgmt *fw_mgmt,
> > 013e6653 Viresh Kumar 2016-05-14  140  					       u8 load_method, const char *tag)
> > 013e6653 Viresh Kumar 2016-05-14  141  {
> > 013e6653 Viresh Kumar 2016-05-14  142  	struct gb_fw_mgmt_load_and_validate_fw_request request;
> > 013e6653 Viresh Kumar 2016-05-14  143  	int ret;
> > 013e6653 Viresh Kumar 2016-05-14  144  
> > 013e6653 Viresh Kumar 2016-05-14  145  	if (load_method != GB_FW_LOAD_METHOD_UNIPRO &&
> > 013e6653 Viresh Kumar 2016-05-14  146  	    load_method != GB_FW_LOAD_METHOD_INTERNAL) {
> > 013e6653 Viresh Kumar 2016-05-14  147  		dev_err(fw_mgmt->parent,
> > 013e6653 Viresh Kumar 2016-05-14  148  			"invalid load-method (%d)\n", load_method);
> > 013e6653 Viresh Kumar 2016-05-14  149  		return -EINVAL;
> > 013e6653 Viresh Kumar 2016-05-14  150  	}
> > 013e6653 Viresh Kumar 2016-05-14  151  
> > 013e6653 Viresh Kumar 2016-05-14  152  	request.load_method = load_method;
> > b2abeaa1 Viresh Kumar 2016-08-11 @153  	strncpy(request.firmware_tag, tag, GB_FIRMWARE_TAG_MAX_SIZE);
> > 013e6653 Viresh Kumar 2016-05-14  154  
> > 013e6653 Viresh Kumar 2016-05-14  155  	/*
> > 013e6653 Viresh Kumar 2016-05-14  156  	 * The firmware-tag should be NULL terminated, otherwise throw error and
> > 013e6653 Viresh Kumar 2016-05-14  157  	 * fail.
> > 013e6653 Viresh Kumar 2016-05-14  158  	 */
> > b2abeaa1 Viresh Kumar 2016-08-11  159  	if (request.firmware_tag[GB_FIRMWARE_TAG_MAX_SIZE - 1] != '\0') {
> > 013e6653 Viresh Kumar 2016-05-14  160  		dev_err(fw_mgmt->parent, "load-and-validate: firmware-tag is not NULL terminated\n");
> > 013e6653 Viresh Kumar 2016-05-14  161  		return -EINVAL;
> > 013e6653 Viresh Kumar 2016-05-14  162  	}

Viresh, do you want to work around the warning somehow?

Thanks,
Johan
