From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v5 2/4] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
Date: Wed, 6 Jun 2018 09:57:14 -0400
Message-ID: <20180606095714.1d3c2def@vmware.local.home>
References: <1528186420-6615-3-git-send-email-changbin.du@intel.com>
        <201806060501.btF3aJMZ%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201806060501.btF3aJMZ%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: changbin.du@intel.com, kbuild-all@01.org, mingo@redhat.com, akpm@linux-foundation.org, yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, rdunlap@infradead.org, x86@kernel.org, linux@armlinux.org.uk, lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sparse@vger.kernel.org, changbin.du@gmail.com
List-Id: linux-sparse@vger.kernel.org

On Wed, 6 Jun 2018 05:21:55 +0800
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
> config: ia64-allmodconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 8.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=ia64 
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers//staging/greybus/fw-management.c: In function 'fw_mgmt_load_and_validate_operation':
> >> drivers//staging/greybus/fw-management.c:153:2: warning: 'strncpy' specified bound 10 equals destination size [-Wstringop-truncation]  
>      strncpy(request.firmware_tag, tag, GB_FIRMWARE_TAG_MAX_SIZE);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers//staging/greybus/fw-management.c: In function 'fw_mgmt_backend_fw_update_operation':
>    drivers//staging/greybus/fw-management.c:304:2: warning: 'strncpy' specified bound 10 equals destination size [-Wstringop-truncation]
>      strncpy(request.firmware_tag, tag, GB_FIRMWARE_TAG_MAX_SIZE);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> --
>    drivers/auxdisplay/panel.c: In function 'panel_bind_key':
> >> drivers/auxdisplay/panel.c:1509:2: warning: 'strncpy' specified bound 12 equals destination size [-Wstringop-truncation]  
>      strncpy(key->u.kbd.press_str, press, sizeof(key->u.kbd.press_str));
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/auxdisplay/panel.c:1510:2: warning: 'strncpy' specified bound 12 equals destination size [-Wstringop-truncation]
>      strncpy(key->u.kbd.repeat_str, repeat, sizeof(key->u.kbd.repeat_str));
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Nice! This patch actually caused bugs in other areas of the code to be
caught by the build system.

The patch is not wrong. The code that has these warnings are.

-- Steve

> 
> vim +/strncpy +153 drivers//staging/greybus/fw-management.c
> 
> 013e6653 Viresh Kumar 2016-05-14  138  
> 013e6653 Viresh Kumar 2016-05-14  139  static int fw_mgmt_load_and_validate_operation(struct fw_mgmt *fw_mgmt,
> 013e6653 Viresh Kumar 2016-05-14  140  					       u8 load_method, const char *tag)
> 013e6653 Viresh Kumar 2016-05-14  141  {
> 013e6653 Viresh Kumar 2016-05-14  142  	struct gb_fw_mgmt_load_and_validate_fw_request request;
> 013e6653 Viresh Kumar 2016-05-14  143  	int ret;
> 013e6653 Viresh Kumar 2016-05-14  144  
> 013e6653 Viresh Kumar 2016-05-14  145  	if (load_method != GB_FW_LOAD_METHOD_UNIPRO &&
> 013e6653 Viresh Kumar 2016-05-14  146  	    load_method != GB_FW_LOAD_METHOD_INTERNAL) {
> 013e6653 Viresh Kumar 2016-05-14  147  		dev_err(fw_mgmt->parent,
> 013e6653 Viresh Kumar 2016-05-14  148  			"invalid load-method (%d)\n", load_method);
> 013e6653 Viresh Kumar 2016-05-14  149  		return -EINVAL;
> 013e6653 Viresh Kumar 2016-05-14  150  	}
> 013e6653 Viresh Kumar 2016-05-14  151  
> 013e6653 Viresh Kumar 2016-05-14  152  	request.load_method = load_method;
> b2abeaa1 Viresh Kumar 2016-08-11 @153  	strncpy(request.firmware_tag, tag, GB_FIRMWARE_TAG_MAX_SIZE);
> 013e6653 Viresh Kumar 2016-05-14  154  
> 013e6653 Viresh Kumar 2016-05-14  155  	/*
> 013e6653 Viresh Kumar 2016-05-14  156  	 * The firmware-tag should be NULL terminated, otherwise throw error and
> 013e6653 Viresh Kumar 2016-05-14  157  	 * fail.
> 013e6653 Viresh Kumar 2016-05-14  158  	 */
> b2abeaa1 Viresh Kumar 2016-08-11  159  	if (request.firmware_tag[GB_FIRMWARE_TAG_MAX_SIZE - 1] != '\0') {
> 013e6653 Viresh Kumar 2016-05-14  160  		dev_err(fw_mgmt->parent, "load-and-validate: firmware-tag is not NULL terminated\n");
> 013e6653 Viresh Kumar 2016-05-14  161  		return -EINVAL;
> 013e6653 Viresh Kumar 2016-05-14  162  	}
> 013e6653 Viresh Kumar 2016-05-14  163  
> 013e6653 Viresh Kumar 2016-05-14  164  	/* Allocate ids from 1 to 255 (u8-max), 0 is an invalid id */
> 013e6653 Viresh Kumar 2016-05-14  165  	ret = ida_simple_get(&fw_mgmt->id_map, 1, 256, GFP_KERNEL);
> 013e6653 Viresh Kumar 2016-05-14  166  	if (ret < 0) {
> 013e6653 Viresh Kumar 2016-05-14  167  		dev_err(fw_mgmt->parent, "failed to allocate request id (%d)\n",
> 013e6653 Viresh Kumar 2016-05-14  168  			ret);
> 013e6653 Viresh Kumar 2016-05-14  169  		return ret;
> 013e6653 Viresh Kumar 2016-05-14  170  	}
> 013e6653 Viresh Kumar 2016-05-14  171  
> 013e6653 Viresh Kumar 2016-05-14  172  	fw_mgmt->intf_fw_request_id = ret;
> 04f0e6eb Viresh Kumar 2016-05-14  173  	fw_mgmt->intf_fw_loaded = false;
> 013e6653 Viresh Kumar 2016-05-14  174  	request.request_id = ret;
> 013e6653 Viresh Kumar 2016-05-14  175  
> 013e6653 Viresh Kumar 2016-05-14  176  	ret = gb_operation_sync(fw_mgmt->connection,
> 013e6653 Viresh Kumar 2016-05-14  177  				GB_FW_MGMT_TYPE_LOAD_AND_VALIDATE_FW, &request,
> 013e6653 Viresh Kumar 2016-05-14  178  				sizeof(request), NULL, 0);
> 013e6653 Viresh Kumar 2016-05-14  179  	if (ret) {
> 013e6653 Viresh Kumar 2016-05-14  180  		ida_simple_remove(&fw_mgmt->id_map,
> 013e6653 Viresh Kumar 2016-05-14  181  				  fw_mgmt->intf_fw_request_id);
> 013e6653 Viresh Kumar 2016-05-14  182  		fw_mgmt->intf_fw_request_id = 0;
> 013e6653 Viresh Kumar 2016-05-14  183  		dev_err(fw_mgmt->parent,
> 013e6653 Viresh Kumar 2016-05-14  184  			"load and validate firmware request failed (%d)\n",
> 013e6653 Viresh Kumar 2016-05-14  185  			ret);
> 013e6653 Viresh Kumar 2016-05-14  186  		return ret;
> 013e6653 Viresh Kumar 2016-05-14  187  	}
> 013e6653 Viresh Kumar 2016-05-14  188  
> 013e6653 Viresh Kumar 2016-05-14  189  	return 0;
> 013e6653 Viresh Kumar 2016-05-14  190  }
> 013e6653 Viresh Kumar 2016-05-14  191  
> 
> :::::: The code at line 153 was first introduced by commit
> :::::: b2abeaa10d5711e7730bb07120dd60ae27d7b930 greybus: firmware: s/_LEN/_SIZE
> 
> :::::: TO: Viresh Kumar <viresh.kumar@linaro.org>
> :::::: CC: Greg Kroah-Hartman <gregkh@google.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
