Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6968C446048;
	Tue, 21 Jul 2026 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784626217; cv=none; b=RWoh+xwYlaovWdySHtRJ5371Y1baJB+VP1H5KnhcxrrvsTSUzDplODeaph5cG+mASw6ohxcWEYWayxynFNKiukiwb/DmwtZSPdHNBe48Dt8skMJR1T+GuFRooR1xCVcfOGjYd5u/dlft3pLWwWf0ZX2npo7zv1Olubq2Q6rHMCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784626217; c=relaxed/simple;
	bh=KOiVVPyJ1rVdVrZF+oVNrN0wvOsC433ZBqN5ZJ9QG20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4nWBP9/1SiscExhb6ZQsHAGPgUJN6cE6qxreOaCqR3gS6b0oXJvpGJAfuvzAB3DO1ZFfuVwYlgl2Mknhw3uTWmTJ2ISD390WZ7km2rFL0WdNqpK9oZlCbzSPbxMWwvoZhfgTCNasYIIiirX4tke/cWfPsDs26+yiVwHTF+wRhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXc/RGN/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXc/RGN/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B811F000E9;
	Tue, 21 Jul 2026 09:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784626216;
	bh=4FrzFFnuliDVci/9RIJav0eot32RM/T7R2sy1IPCPQg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cXc/RGN/EEk3TA8+aWGro2/Fnx0tx4VqletVomXjKh/MSCMNlLx1DvtbKHqHpwRkk
	 Xj67CelJVOCdIPCsBc72IOTX+qyup/LH7e1bvo6gbcLLcyrbUiKhrBTWnQHDx1xCiq
	 j9Oc4h2q5V8Jl6XngRVlWWEj5qjlVdyQle/2DzW8pO2kv7uuBBgPuW7MQ7OjiMW5vj
	 9gJhUKy09s8CjJcwgG5wrlSzJ5V8CX7ay6frImypxxbVDDnTiyEBtzNPo77T14zyKc
	 +Hfqfc19ZH2fj7LV8n2x8bLlryY18726tYTYi/nEKE+aBZXSTBz2/Y0hbAvU3xM4IQ
	 /gFH45HHc69oQ==
Message-ID: <9e399c58-38c7-4c98-b22e-77f04f8b9f5b@kernel.org>
Date: Tue, 21 Jul 2026 11:30:11 +0200
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slab: silence sparse warning with type-based partitioning
Content-Language: en-US
To: Marco Elver <elver@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Chris Li <sparse@chrisli.org>
Cc: Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 kernel test robot <lkp@intel.com>, linux-sparse@vger.kernel.org
References: <20260721092005.1986693-1-elver@google.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSNWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBrZXJuZWwub3JnPsLBsAQTAQoAWhYhBKlA1DSZLC6OmRA9UCJPp+fM
 gqZkBQJqFFy6GxSAAAAAAAQADm1hbnUyLDIuNSsxLjEyLDIsMgIbAwUJGtCBUAULCQgHAwUV
 CgkICwUWAgMBAAIeBQIXgAAKCRAiT6fnzIKmZJIUEADFx/tREzUImHrEwVHeSvDFmA7tJysI
 UVrlvrM09E7GIuzphzv7jYmo8n3ANpCczLEVr4G0syYQdTigaZgv3+FQDIIzhKih1IHhu1Ei
 XHlywNWKnQxxQEUNi5Mwx43wQz5XVw9F1A7gtKBKNtfogO511hAbrzagrYajyQacEJ/+sfhZ
 9Da8ltHIXD8pcYaHUfQgEusCgmEd9+KrUwrTbckFKmYq5chuE6yJ4J0EmWknL096jIE6CnzF
 FRslQ3B1UKDjxVsm1ZHfir5NeWszLkTvGFsddFaWTgh8UycESG6VQzKXjjewXu2pG7YQYRpj
 QKm1W5X2TkwWkXRBZTmfmbhxIUMh3+zf5wQ463rSmDN/8v81tdqBtAW6rH/kzg1GvkaTHXn0
 507yEHFzBksk2viAuIxxr7km8+/KARYLIdGtx30EG8cKzAUZOK6WqxtNCsXUJNrVE8CWrCaD
 icoNu7Fs1c5hmPHdSTnU48ce67449DdnO4neLSNhRiGlMHJgfJUmgrxu/hcYeOZ3haWmEQ2w
 uW1Mh01OHi8QZHCEyAbABrPs9GUgccc/4eYXX9hIgxfSkYzn8f+8NuIFPWl/0uTvjgqU29FQ
 SbzOLxHq9439Ox40G5mS5eZXRGxITYR+6TXvRGI6P/264jvflnr/pDGUttaikU+0W+1uxgKH
 cmYbEc7ATQRbGTU1AQgAn0H6UrFiWcovkh6EXVcl+SeqyO6JHOPm+e9Wu0Vw+VIUvXZVUVVQ
 La1PQDUi6j00ChlcR66g9/V0sPIcSutacPKfdKYOBvzd4rlhL8rfrdEsQw5ApZxrA8kYZVMh
 FmBRKAa6wos25moTlMKpCWzTH84+WO5+ziCTsTUZASAToz3RdunTD+vQcHj0GqNTPAHK63sf
 bAB2I0BslZkXkY1RLb/YhuA6E7JyEd2pilZOrIuBGl/5q2qSakgnAVFWFBR/DO27JuAksYnq
 +aH8vI0xGvwn75KqSk4UzAkDzWSmO4ZHuahKtQgZNsMYV+PGayRBX9b9zbldzopoLBdqHc4n
 jQARAQABwsF8BBgBCgAmAhsMFiEEqUDUNJksLo6ZED1QIk+n58yCpmQFAmfIHFQFCRYU6J8A
 CgkQIk+n58yCpmS2PA//bqN1LfcotmArgElsa+0EGZSQlYgK48pm8WAeTXTngudP9IJ4SuKY
 HR5RNjHcBeqN+Me0zxRqYzRb8nGanHEkDyf4Im8DQM8d6vbyU+FcPmG4skud4kgS1zMHnlVd
 SXfSIwKC/hKgdHG8aBV7545Lz9X6Iohea+94wneD0aw/hqF+QWewGZhWJriWAZtvEkzNjQOi
 4U9F/trLten/x7bpphDSnDMKJtITbtzATT1Dq7o7VpIUK1nCTQALMuMjKCdi8OdU/+V+R3O4
 0PXWvX8qrvqYapVbZ+9KqT74FsuB0Ya9uXwgBF2Q6cRuETZk5vqaqKxzqoQZCO8AOz/58j6O
 2RHNy/mZEN+7tJ5Tsq42zVJ4jxsT8b9YplavCMsnBgDeRWhcbYhCyttoL7nYISyWg4kQYZ/P
 wIV3OuNv2f8iKYsxNsRuClOAF82+gvqOy1/1pprFjy8uo2pkoOrb63aOP3vO5VHnRKgra6dq
 NcaZ+c6J4H+nEJGi2SkHAUJz5oBzuThvPudLvPA/SK8sKoM01IRxSihev/S/5WLazXB1PGem
 OCbvzC1IjWJJraxiDJ5IygokapUa2RP7+WBR22skQ3SSl6G107QgWKSyTOGWEaRmV53vxQLV
 jXuCmzSSasTL60zq5yGrT4/DYQVSNEUiUbG4pYekxJujNeEDkUlky0Y=
In-Reply-To: <20260721092005.1986693-1-elver@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/26 11:19, Marco Elver wrote:
> Sparse does not know __builtin_infer_alloc_token() and complains:
> 
> 	sparse: sparse: undefined identifier '__builtin_infer_alloc_token'
> 
> Fix it by using a dummy variant of __kmalloc_token() if __CHECKER__ is
> defined.
> 
> Fixes: feb662d9168b ("slab: support for compiler-assisted type-based slab cache partitioning")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202607110912.nZTqfCrH-lkp@intel.com/
> Signed-off-by: Marco Elver <elver@google.com>

Added to slab/for-next-fixes, thanks!

> ---
>  include/linux/slab.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 51f03f18c9a7..7ffe152ce483 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -505,8 +505,12 @@ typedef struct { unsigned long v; } kmalloc_token_t;
>  extern unsigned long random_kmalloc_seed;
>  #define __kmalloc_token(...) ((kmalloc_token_t){ .v = _CODE_LOCATION_ })
>  #elif defined(CONFIG_KMALLOC_PARTITION_TYPED)
> +#ifdef __CHECKER__
> +#define __kmalloc_token(...) ((kmalloc_token_t){ .v = 0 })
> +#else /* !__CHECKER__ */
>  #define __kmalloc_token(...) ((kmalloc_token_t){ .v = __builtin_infer_alloc_token(__VA_ARGS__) })
> -#endif
> +#endif /* __CHECKER__ */
> +#endif /* CONFIG_KMALLOC_PARTITION_TYPED */
>  #define DECL_TOKEN_PARAM(_token)	, kmalloc_token_t (_token)
>  #define _PASS_TOKEN_PARAM(_token)	, (_token)
>  #define PASS_TOKEN_PARAM(_token)	(_token)

