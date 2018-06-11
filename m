From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v5 2/4] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
Date: Mon, 11 Jun 2018 17:46:33 +0200
Message-ID: <20180611154633.GC13775@localhost>
References: <20180606095714.1d3c2def@vmware.local.home>
 <20180606142600.GN13775@localhost>
 <20180606142622.2338abf6@vmware.local.home>
 <20180607041718.qpqucjzlvcm5h3gn@vireshk-i7>
 <20180607074628.kd3iyxevwj3ypzbr@intel.com>
 <20180607083856.ealw62v3wx43zeqz@vireshk-i7>
 <1303b1abf9f9229a8d3ccbb68a3e413266b360d7.camel@petrovitsch.priv.at>
 <20180607091025.m7dfix3e2xbwx4cs@vireshk-i7>
 <20180607091816.GT13775@localhost>
 <20180608160355.67712eb8@vmware.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180608160355.67712eb8@vmware.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Johan Hovold <johan@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Bernd Petrovitsch <bernd@petrovitsch.priv.at>, "Du, Changbin" <changbin.du@intel.com>, gregkh@linuxfoundation.org, alex.elder@linaro.org, kbuild test robot <lkp@intel.com>, linux-arch@vger.kernel.org, michal.lkml@markovi.net, linux-kernel@vger.kernel.org, arnd@arndb.de, yamada.masahiro@socionext.com, lgirdwood@gmail.com, broonie@kernel.org, rdunlap@infradead.org, x86@kernel.org, linux@armlinux.org.uk, linux-sparse@vger.kernel.org, mingo@redhat.com, kbuild-all@01.org, akpm@linux-foundation.org, changbin.du@gmail.com, tglx@linutronix.de, linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-sparse@vger.kernel.org

On Fri, Jun 08, 2018 at 04:03:55PM -0400, Steven Rostedt wrote:
> On Thu, 7 Jun 2018 11:18:16 +0200
> Johan Hovold <johan@kernel.org> wrote:
> 
> 
> > If you want to work around the warning and think you can do it in some
> > non-contrived way, then go for it.
> > 
> > Clearing the request buffer, checking for termination using strnlen, and
> > then using memcpy might not be too bad.
> > 
> > But after all, it is a false positive, so leaving things as they stand
> > is fine too.
> 
> Not sure how contrived you think this is, but it solves the warning
> without adding extra work in the normal case.
> 
> -- Steve
> 
> diff --git a/drivers/staging/greybus/fw-management.c b/drivers/staging/greybus/fw-management.c
> index 71aec14f8181..4fb9f1dff47d 100644
> --- a/drivers/staging/greybus/fw-management.c
> +++ b/drivers/staging/greybus/fw-management.c
> @@ -150,15 +150,18 @@ static int fw_mgmt_load_and_validate_operation(struct fw_mgmt *fw_mgmt,
>  	}
>  
>  	request.load_method = load_method;
> -	strncpy(request.firmware_tag, tag, GB_FIRMWARE_TAG_MAX_SIZE);
> +	strncpy(request.firmware_tag, tag, GB_FIRMWARE_TAG_MAX_SIZE - 1);
>  
>  	/*
>  	 * The firmware-tag should be NULL terminated, otherwise throw error and
>  	 * fail.
>  	 */
> -	if (request.firmware_tag[GB_FIRMWARE_TAG_MAX_SIZE - 1] != '\0') {
> -		dev_err(fw_mgmt->parent, "load-and-validate: firmware-tag is not NULL terminated\n");
> -		return -EINVAL;
> +	if (request.firmware_tag[GB_FIRMWARE_TAG_MAX_SIZE - 2] != '\0') {
> +		if (tag[GB_FIRMWARE_TAG_MAX_SIZE - 1] != '\0') {
> +			dev_err(fw_mgmt->parent, "load-and-validate: firmware-tag is not NULL terminated\n");
> +			return -EINVAL;
> +		}
> +		request.firmware_tag[GB_FIRMWARE_TAG_MAX_SIZE - 1] = '\0';
>  	}

Well, I think it's quite far from obvious what is going on above, and
not least why things are being done this way (which a comment may help
with).

And just NUL-terminating the (automatic) buffer before returning wasn't
enough? Then it may be better to do away with strncpy completely.

But should we really be working around gcc this way? If the
implementation of this new warning isn't smart enough yet, should it not
just be disabled instead?

Thanks,
Johan
