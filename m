From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 5/7] signal: Silence nested-externs warnings
Date: Fri, 19 Sep 2014 17:35:51 +0200
Message-ID: <541C4D57.9050507@nod.at>
References: <1411140580-20909-1-git-send-email-jeffrey.t.kirsher@intel.com> <1411140580-20909-6-git-send-email-jeffrey.t.kirsher@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411140580-20909-6-git-send-email-jeffrey.t.kirsher@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>, sparse@chrisli.org
Cc: Mark Rustad <mark.d.rustad@intel.com>, linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Brian Norris <computersforpeace@gmail.com>
List-Id: linux-sparse@vger.kernel.org

Am 19.09.2014 17:29, schrieb Jeff Kirsher:
> From: Mark Rustad <mark.d.rustad@intel.com>
> 
> Silence nested-externs warnings for these, as these nested
> externs are truly wanted.
> 
> CC: Oleg Nesterov <oleg@redhat.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Geert Uytterhoeven <geert@linux-m68k.org>
> CC: Richard Weinberger <richard@nod.at>
> CC: Brian Norris <computersforpeace@gmail.com>
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  include/linux/signal.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/signal.h b/include/linux/signal.h
> index 750196f..e68ae6b 100644
> --- a/include/linux/signal.h
> +++ b/include/linux/signal.h
> @@ -67,7 +67,9 @@ static inline int sigismember(sigset_t *set, int _sig)
>  
>  static inline int sigisemptyset(sigset_t *set)
>  {
> +	DIAG_PUSH DIAG_IGNORE(nested-externs)

Do we really want to clutter the source with such tags?
Does this even build? i.e. how does gcc know to ignore that?

rw@azrael:~/linux (ubi-wlcrash $)> git grep DIAG_PUSH | wc -l
0

Thanks,
//richard
