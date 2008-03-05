From: Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>
Subject: Re: [PATCH 6/9] drivers/net/wireless/iwlwifi/iwl-4965.c: Correct
	use of ! and &
Date: Wed, 5 Mar 2008 07:38:42 +0100
Message-ID: <20080305063842.GA24495@elte.hu>
References: <Pine.LNX.4.64.0802262143570.18200@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0802262143570.18200-QfmoRoYWmW9knbxzx/v8hQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>
Cc: yi.zhu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ipw3945-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexander Viro <viro-rfM+Q5joDG/XmaaqVzeoHQ@public.gmane.org>, linux-sparse-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Josh Triplett <josh-CC+yJ3UmIYqDUpFQwHEjaQ@public.gmane.org>
List-Id: linux-sparse@vger.kernel.org


* Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org> wrote:

> From: Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>
> 
> In commit e6bafba5b4765a5a252f1b8d31cbf6d2459da337, a bug was fixed 
> that involved converting !x & y to !(x & y).  The code below shows the 
> same pattern, and thus should perhaps be fixed in the same way.

>  	if (sta_ht_inf) {
>  		if ((!sta_ht_inf->ht_supported) ||
> -		   (!sta_ht_inf->cap & IEEE80211_HT_CAP_SUP_WIDTH))
> +		   (!(sta_ht_inf->cap & IEEE80211_HT_CAP_SUP_WIDTH)))
>  			return 0;

i'm wondering, could Sparse be extended to check for such patterns? 

People are regularly running "make C=1" and are sending fixes to make 
entire subsystems sparse-warning-free, so Sparse is a nice mechanism 
that works and it keeps code clean in the long run.

I dont think the "!X & Y" pattern is ever used legitimately [and even if 
it were used legitimately, it's easy to avoid the sparse false positive 
- while in the buggy case we have a clear bug].

	Ingo
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
