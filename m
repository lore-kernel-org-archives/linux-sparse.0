Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792599694;
	b=HlNBwE6vV3/zelEjvAVNWfxYaNUvG+zFajqaN++J2LyallSOr6AXm6cVFNsecMifN+rd
	 sCumZ6n2bASZHEKWKbpTv7FkGUEqoJnE7X1N657coyak4I8+ZLJf3H2fXruHSNzbtuffn
	 eSWDiL2nalhWA+h7Z7kconBlwgKTUpUnFk/8IqvrB/r1lsym3WGlbQ2BGCLqReGvqPI3d
	 P9MxSIyyMCk7mE/fSHPEsYpIRPD0EdwYFmmsTrAHDrqCnk0S91l3i0bzkirbLIZMsSyfl
	 2lOi1N7wLlX5wg/l6l0WwxtGqhdO5AB0TErgPOehu1fIyeOnwUiSibEY1peOvTThZhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599694;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=fEFkzapRRb2zfWbjPS34/fgqmWMqVbFOxbYT+rTC1Aw=;
	b=nMYMRoTtS4hR2M+NmGTvBWfYDg756IJC9jwVi4QUu5uj7MJPRjQQvv0BOmXR2N7v52UT
	 wwEewmDp6FRr+8BpbWwaO980t9TSK4Bd1AdESSZ8UV7sL0FMn79t/f9/E9H4lhCXGfQc3
	 myHE0bHkvtM1+20FOUc7iWUryZzG+NBjGyhgfXL06EOoJQPanrh14yIGF4lk9OhRNxeaO
	 ARPMZQpKlbVV+Fs0TvdEpyQWc7n2rN3+cJwzP0LomRFowbi+NuvAaCpZkg0X9NLumyRic
	 oDoVzrlR0pSfrjQsjztuJBNyJnUxhu04bEpN6DAL2m8PTd5QYXUlsLwIaVRZkxjPM1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b="h/eNe0kN";
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEBA606A55A
	for <linux-sparse@vger.kernel.org>; Wed, 21 Oct 2026 16:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BEBA606A55A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=h/eNe0kN
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j8vg10sqtz1XM4Tn;
	Wed, 21 Oct 2026 16:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1792599691; x=1795191692; bh=fEFkzapRRb2zfWbjPS34/fgq
	mWMqVbFOxbYT+rTC1Aw=; b=h/eNe0kN1Jtyuy63T5zTNhaatcyI4bEX96KN6zkw
	F+8xHR1sm8cNuMtqK6+yklJOdqi0QbAHP9HTUf5Afpjfq7Pxcfguj7O/F3GXEqFr
	keKMevKZsgRoEUznxeRN8AHlI2R3KppeDZOkR1uJ8/86pa2aaZX6PVlMlL4kHGx1
	Butc5Em3m8zt9/cm+Q6dgQuYEgkwev87pPom1jseuWELm48R+aMwmBT90iP47Gjd
	aeNowwWgR7GrJDdfb5biLEB0dQbGiUwp6/o9YDUg8/I0m9uK8b0/h80fNOdSc4K4
	7IUoxepNhOfNd/h5r6TfCo+F0uvtz8GxDPyYfRNbVSqd+g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 4LkZDFMar8y7; Wed, 21 Oct 2026 16:21:31 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j8vfy67Fzz1XM4Tl;
	Wed, 21 Oct 2026 16:21:30 +0000 (UTC)
Message-ID: <fccb8375-0f03-4e0f-add8-f0c7f1c95736@acm.org>
Date: Wed, 21 Oct 2026 09:21:30 -0700
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Post: <mailto:linux-sparse@vger.kernel.org>
List-Help: <mailto:linux-sparse+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sparse+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/20] storage: Free hash table entries when freeing
 storage
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: linux-sparse@vger.kernel.org
References: <20261019175633.415493-1-bvanassche@acm.org>
 <20261019175633.415493-5-bvanassche@acm.org>
 <atjDNHM_tTvU8CE7@shell.ilvokhin.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <atjDNHM_tTvU8CE7@shell.ilvokhin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/26 6:50 AM, Dmitry Ilvokhin wrote:
> On Mon, Oct 19, 2026 at 10:56:17AM -0700, Bart Van Assche wrote:
>> Free allocated hash table entries when freeing storage structures in
>> storage.c to prevent memory leaks during storage teardown.
>>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>   storage.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/storage.c b/storage.c
>> index 6fc6e3d7085f..160d424ee1f6 100644
>> --- a/storage.c
>> +++ b/storage.c
>> @@ -159,12 +159,18 @@ static void vrfy_storage(struct storage_hash_list **listp)
>>   
>>   void free_storage(void)
>>   {
>> +	struct storage_hash_list *all = NULL;
>>   	int i;
>>   
>>   	for (i = 0; i < MAX_STORAGE_HASH; i++) {
>> -		vrfy_storage(storage_hash_table + i);
>> +		struct storage_hash *entry;
>> +		FOR_EACH_PTR(storage_hash_table[i], entry) {
>> +			add_ptr_list(&all, entry);
>> +		} END_FOR_EACH_PTR(entry);
>>   		free_ptr_list(storage_hash_table + i);
>>   	}
>> +	vrfy_storage(&all);
>> +	free_ptr_list(&all);
>>   }
> 
> This seems like a behaviour change (a correct one, as far as I can
> tell), that is not mentioned in the changelog. Before verification was
> done for each bucket independently and could miss conflicts, while now
> verification is done globally.
> 
> Does it worth to split this hunk it is own commit with the proper
> description?

Does replacing the above patch with the two patches below address your
feedback?

Thanks,

Bart.

----------------------------------------------------------------------
From: Bart Van Assche <bvanassche@acm.org>
Date: Wed, 21 Oct 2026 09:04:56 -0700
Subject: [PATCH 1/2] storage: Verify storage conflicts across all hash 
buckets

The storage hash table is indexed by a hash of (bb, pseudo, inout).
vrfy_storage() reports a conflict if two different pseudos in the same
basic block and with the same direction have been assigned the same
storage. Since such entries have a different pseudo, they typically
end up in different hash buckets. Hence, calling vrfy_storage() for
each bucket separately misses most conflicts.

Collect all hash table entries into a single list before calling
vrfy_storage() such that conflicts are detected independent of the
hash bucket an entry has been stored in.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
  storage.c | 8 +++++++-
  1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/storage.c b/storage.c
index 6fc6e3d7085f..d99d3af2ec18 100644
--- a/storage.c
+++ b/storage.c
@@ -159,12 +159,18 @@ static void vrfy_storage(struct storage_hash_list 
**listp)

  void free_storage(void)
  {
+	struct storage_hash_list *all = NULL;
  	int i;

  	for (i = 0; i < MAX_STORAGE_HASH; i++) {
-		vrfy_storage(storage_hash_table + i);
+		struct storage_hash *entry;
+		FOR_EACH_PTR(storage_hash_table[i], entry) {
+			add_ptr_list(&all, entry);
+		} END_FOR_EACH_PTR(entry);
  		free_ptr_list(storage_hash_table + i);
  	}
+	vrfy_storage(&all);
+	free_ptr_list(&all);
  }

  const char *show_storage(struct storage *s)
----------------------------------------------------------------------
From: Bart Van Assche <bvanassche@acm.org>
Date: Wed, 21 Oct 2026 09:04:57 -0700
Subject: [PATCH 2/2] storage: Free the users list in combine_storage()

combine_storage() marks the source storage as unused by setting its
users list pointer to NULL. This leaks the memory allocated for that
list. Free the list instead of only clearing the pointer.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
  storage.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/storage.c b/storage.c
index d99d3af2ec18..160d424ee1f6 100644
--- a/storage.c
+++ b/storage.c
@@ -214,7 +214,7 @@ static struct storage * combine_storage(struct 
storage *src, struct storage *dst

  	/* Mark it unused */
  	src->type = REG_BAD;
-	src->users = NULL;
+	free_ptr_list(&src->users);
  	return dst;
  }

----------------------------------------------------------------------

