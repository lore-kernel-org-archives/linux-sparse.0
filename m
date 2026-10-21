Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.62.254.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590648;
	b=mVjBsFoSGRU6ymPnRB5BqfCL1hIqwM4MoV2XFtXEie9GMVBjx5lnk8AJFp/99yKHBUHg
	 FhEifcxDlObjVQqYsR+U0+SxtRGXMBhC8Kn5zm4/qVArWu9EwF6X6NK4+y7eS8IH2e9Y0
	 eGAVX24yH7rSibY9Gev8Kyg9guGwm44UUyy1IeWcEBwB+JzSCoWHazWuOqCYdrdOTQNf/
	 yHVtnTNsDaTRlORqhbWgmLXjYhBQgN6C8YdWbM8llZeHWpZPmntX8/N2LdMuhqXiITpKK
	 Wylp/1Y4jmfsqUrBBvLaxsOtWsnqntuJhCHobLkFp/5J358xLJXKo/BZ2yfwKTpZdSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590648;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=pOCP3SlDKDbEd3i+0mlgJTZqFhumEpEsstvKJVB2zUE=;
	b=u3PXaT0+dAj9X9wOy650ID9Gc1PMQ1Lv2v0W95oX/ovzR0uboS9zmLbRJshEzDtKweqg
	 ztIDZ2HowCBAK1QxWAMPXiGcNjKui4d31JGhS4uTfB6jejwE8AmOMmCQv7JZQllbA/oF2
	 J3YVAsu7X8oUyB94l02Q+z7pkW+gGyAy1+KKVgbN2uItOK8MRxrRf0Jb0LvXx49FbYeGp
	 qSWnkTCuU4lbZShogyJFiNzaqQudLdoF68KxKcvOV6qCL4jkQg3aURx6AIMSeHhBjiIqo
	 eLb0XhOkb++vnnbMS62mLZcCKn+t2h4uTb+3fF7wgermqRAVqsXxYliN3GjxGqkI0Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ilvokhin.com;
	spf=pass smtp.mailfrom=ilvokhin.com;
	dkim=pass header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=vyovHbwl;
	arc=none smtp.remote-ip=178.62.254.231
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7A5606A324
	for <linux-sparse@vger.kernel.org>; Wed, 21 Oct 2026 13:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD7A5606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=vyovHbwl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1792590646;
	bh=pOCP3SlDKDbEd3i+0mlgJTZqFhumEpEsstvKJVB2zUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=vyovHbwllNdUGgdrW2i+hzX953cUdpu3wAM/bdn9dFbtBnxGPzUL1akIVlERiqwR/
	 fgcoe/S9zIKKjE+fJGQBIZI8xUW+Z/WTFGYqfkiQeyMQkjmDcvA8hZ5tdQSqFPukkk
	 nxBQFIUFvimHuKekPT67WcEVkDzIfPlsyAv6cBp4=
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 13711FB957;
	Wed, 21 Oct 2026 13:50:46 +0000 (UTC)
Date: Wed, 21 Oct 2026 13:50:44 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-sparse@vger.kernel.org
Subject: Re: [PATCH 04/20] storage: Free hash table entries when freeing
 storage
Message-ID: <atjDNHM_tTvU8CE7@shell.ilvokhin.com>
References: <20261019175633.415493-1-bvanassche@acm.org>
 <20261019175633.415493-5-bvanassche@acm.org>
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Post: <mailto:linux-sparse@vger.kernel.org>
List-Help: <mailto:linux-sparse+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sparse+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019175633.415493-5-bvanassche@acm.org>

On Mon, Oct 19, 2026 at 10:56:17AM -0700, Bart Van Assche wrote:
> Free allocated hash table entries when freeing storage structures in
> storage.c to prevent memory leaks during storage teardown.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  storage.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/storage.c b/storage.c
> index 6fc6e3d7085f..160d424ee1f6 100644
> --- a/storage.c
> +++ b/storage.c
> @@ -159,12 +159,18 @@ static void vrfy_storage(struct storage_hash_list **listp)
>  
>  void free_storage(void)
>  {
> +	struct storage_hash_list *all = NULL;
>  	int i;
>  
>  	for (i = 0; i < MAX_STORAGE_HASH; i++) {
> -		vrfy_storage(storage_hash_table + i);
> +		struct storage_hash *entry;
> +		FOR_EACH_PTR(storage_hash_table[i], entry) {
> +			add_ptr_list(&all, entry);
> +		} END_FOR_EACH_PTR(entry);
>  		free_ptr_list(storage_hash_table + i);
>  	}
> +	vrfy_storage(&all);
> +	free_ptr_list(&all);
>  }

This seems like a behaviour change (a correct one, as far as I can
tell), that is not mentioned in the changelog. Before verification was
done for each bucket independently and could miss conflicts, while now
verification is done globally.

Does it worth to split this hunk it is own commit with the proper
description?
