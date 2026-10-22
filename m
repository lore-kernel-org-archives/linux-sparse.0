Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.62.254.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792669181;
	b=rXqhWUZxeOZUPStAa0wJ0jxRSC/ed7E8Vp1RKehwwq2QG64+QOpTSTeajmLfov9i+3Vx
	 fwBdCIbjD7SXPDBvrm1TxGInx5OGb/mxsbcrZTrmBwDszp7J/mji4IkeOv1Uhgl7vDIuy
	 II5l1wZjDvKYHBLzP6WGaQvHtPz4j2N9YLh8iNuHQvRpqDmrwcWT5WB4faON0GU/fwh9j
	 WbuUMPWyPYjf/Ydeo6DL2WAhuoxL/ENO6snW/60laUgSdDrenF8Mdk04MXmd0WoAlY2HF
	 cvFU3bq6odlWlMN2+gy+6U7m1lw9xBgrVM85V+yk+jZN/MVXbyiDDFdp2j5BNaBSMUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792669181;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=tXHOWYHUb72pTDIrrIaEVpi6iAmU3txukIkGiyorsSo=;
	b=trQ+0N6PFHDh/WeJHT9ltr8KUa6Yu5w93uNpqZJAToBc7OVau+jwLGlyDf/u80h2EZGS
	 F9K7Q42/rQzdF+AfOuFEEUgh/h3ocoGfV4NWSqSCzUIh54mym6IA0PSAoYVOM5TCkRGPn
	 kyS8NiyRRZVvDr4+m2BdmZUXFj/D4cFktdMKcLwPffxn+UNROaKj/Oo+t5NEaATAxuqfn
	 BQbhffdhTbiEAIJKPAKDl07mjip/0uGKSipCjh0dVyNmVPgYcbSd7lq1aCb3VjPLxai0n
	 i0NuAWR4FiIzuMiW75yJGsg022oAFO1yoh3j8GrWp38z35YFvhtYD7sjGs6w4304pRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ilvokhin.com;
	spf=pass smtp.mailfrom=ilvokhin.com;
	dkim=pass header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=ygOxxHGG;
	arc=none smtp.remote-ip=178.62.254.231
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9447606A319
	for <linux-sparse@vger.kernel.org>; Thu, 22 Oct 2026 11:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9447606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=ygOxxHGG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1792669179;
	bh=tXHOWYHUb72pTDIrrIaEVpi6iAmU3txukIkGiyorsSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ygOxxHGG0kGNoVazmZoiPLWwjeOSQsyGR5RsK9jtt9K54gNjNb2Hk/XSN2ASk5Aru
	 xAI1ZN7oX2559kiJ1dhcXEU5QaQRtxYPctip4U3B65Quupe2nyDS5aXhjtRAIzV3Fn
	 JFPdj8JRGd5rgxFGGAO3T/uBAWatAVEUgdciDaKo=
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 1B734FBA4A;
	Thu, 22 Oct 2026 11:39:39 +0000 (UTC)
Date: Thu, 22 Oct 2026 11:39:37 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-sparse@vger.kernel.org
Subject: Re: [PATCH 04/20] storage: Free hash table entries when freeing
 storage
Message-ID: <atn1-SE3a3EC78NX@shell.ilvokhin.com>
References: <20261019175633.415493-1-bvanassche@acm.org>
 <20261019175633.415493-5-bvanassche@acm.org>
 <atjDNHM_tTvU8CE7@shell.ilvokhin.com>
 <fccb8375-0f03-4e0f-add8-f0c7f1c95736@acm.org>
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
In-Reply-To: <fccb8375-0f03-4e0f-add8-f0c7f1c95736@acm.org>

On Wed, Oct 21, 2026 at 09:21:30AM -0700, Bart Van Assche wrote:
> On 10/21/26 6:50 AM, Dmitry Ilvokhin wrote:
> > On Mon, Oct 19, 2026 at 10:56:17AM -0700, Bart Van Assche wrote:
> > > Free allocated hash table entries when freeing storage structures in
> > > storage.c to prevent memory leaks during storage teardown.
> > > 
> > > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> > > ---
> > >   storage.c | 10 ++++++++--
> > >   1 file changed, 8 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/storage.c b/storage.c
> > > index 6fc6e3d7085f..160d424ee1f6 100644
> > > --- a/storage.c
> > > +++ b/storage.c
> > > @@ -159,12 +159,18 @@ static void vrfy_storage(struct storage_hash_list **listp)
> > >   void free_storage(void)
> > >   {
> > > +	struct storage_hash_list *all = NULL;
> > >   	int i;
> > >   	for (i = 0; i < MAX_STORAGE_HASH; i++) {
> > > -		vrfy_storage(storage_hash_table + i);
> > > +		struct storage_hash *entry;
> > > +		FOR_EACH_PTR(storage_hash_table[i], entry) {
> > > +			add_ptr_list(&all, entry);
> > > +		} END_FOR_EACH_PTR(entry);
> > >   		free_ptr_list(storage_hash_table + i);
> > >   	}
> > > +	vrfy_storage(&all);
> > > +	free_ptr_list(&all);
> > >   }
> > 
> > This seems like a behaviour change (a correct one, as far as I can
> > tell), that is not mentioned in the changelog. Before verification was
> > done for each bucket independently and could miss conflicts, while now
> > verification is done globally.
> > 
> > Does it worth to split this hunk it is own commit with the proper
> > description?
> 
> Does replacing the above patch with the two patches below address your
> feedback?
> 

Thanks, Bart. This is exactly what I had in mind.

Feel free to add for both patches:

Reviewed-by: Dmitry Ilvokhin <d@ilvokhin.com>
