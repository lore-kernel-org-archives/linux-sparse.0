From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] staging: rtl8192u: initialize array in C compliant way
Date: Tue, 6 May 2014 11:47:49 +0300
Message-ID: <20140506084749.GT26890@mwanda>
References: <1399364528-3727-1-git-send-email-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1399364528-3727-1-git-send-email-martink@posteo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, burzalodowa@gmail.com, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Tue, May 06, 2014 at 10:22:08AM +0200, Martin Kepplinger wrote:
> Don't list elements to initialize. Remaining elements of a partly
> initialized array are set to zero. Sparse complained here.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> ---
>  drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
> index 426f223..c96dbab 100644
> --- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
> +++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
> @@ -241,7 +241,7 @@ static PTS_COMMON_INFO SearchAdmitTRStream(struct ieee80211_device *ieee,
>  {
>  	//DIRECTION_VALUE	dir;
>  	u8	dir;
> -	bool				search_dir[4] = {0, 0, 0, 0};
> +	bool				search_dir[4] = {0};

That's weird.  The original code is valid but it generates a sparse
warning.

drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c:244:58: warning: Initializer entry defined twice
drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c:244:61:   also defined here

It has something to do with "_Bool" types.  Changing it to "int" will
also make the warning disappear.  I've CC'd the sparse list to see if
anyone knows what's happening.

regards,
dan carpenter
