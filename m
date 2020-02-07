From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH bpf] bpf: Improve bucket_log calculation logic
Date: Fri, 7 Feb 2020 14:07:21 +0100
Message-ID: <20200207130721.pitlvbxcx656c7ur@ltop.local>
References: <20200207081810.3918919-1-kafai@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200207081810.3918919-1-kafai@fb.com>
Sender: netdev-owner@vger.kernel.org
To: Martin KaFai Lau <kafai@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, David Miller <davem@davemloft.net>, kernel-team@fb.com, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
List-Id: linux-sparse@vger.kernel.org

On Fri, Feb 07, 2020 at 12:18:10AM -0800, Martin KaFai Lau wrote:
> 
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index 458be6b3eda9..3ab23f698221 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -643,9 +643,10 @@ static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
>  		return ERR_PTR(-ENOMEM);
>  	bpf_map_init_from_attr(&smap->map, attr);
>  
> +	nbuckets = roundup_pow_of_two(num_possible_cpus());
>  	/* Use at least 2 buckets, select_bucket() is undefined behavior with 1 bucket */
> -	smap->bucket_log = max_t(u32, 1, ilog2(roundup_pow_of_two(num_possible_cpus())));
> -	nbuckets = 1U << smap->bucket_log;
> +	nbuckets = max_t(u32, 2, nbuckets);
> +	smap->bucket_log = ilog2(nbuckets);
>  	cost = sizeof(*smap->buckets) * nbuckets + sizeof(*smap);
>  
>  	ret = bpf_map_charge_init(&smap->map.memory, cost);
> -- 

Yes, that's much nicer to read. Feel free to add my

Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

-- Luc
