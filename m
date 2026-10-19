Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432612;
	b=o1UM5ocPVwq9LMuMo92whPLM/7VA1iDeyujzTixKVQm4LRCSz6Bc1EhU0/xYQZi3JXsu
	 kkAq9FAIHqdqim9On4HKr3xYzLjt9nxC6i7iVmQPvDFpjQI++mErqGzkeKxfAhtsHhBBI
	 5DMDoIxxSii7ow16iK7sCXFRcHJDCUCFq5URaEhgNNmJ0IvR/S+B+q7+l9WaTYSVTM0vl
	 xR7rO+ozxlRFkNsL5q0F+MuPPxEh3art2ELUNuHw1//Y7kpR+mp51WXviWxJk7ciUQSqu
	 Qz70PptdUoor0QFO26wGT5kOntjIn4Pk/MBf9wNCyYIV2GYlJzA6WyesOo07TyCq0zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432612;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=O74b0zaJiBy9pbR1A6GrNxAyLKlyg1PUDTmkPeBPHNU=;
	b=eowm0/10Z4Q+CWMzlkkEsAKaQ8dh0TewObaJ7zQjFELVIqx/3+SZ8wqPKtlVigeFb9D+
	 Jv/KAlPRyEkpswix4KibErANIIWacNLA93hw/BqexeFhTuyJy36ikMflxX21Oyj5Xbu9a
	 L8OAR4cY+mJjMRSG1674TffrfiyHrHKNu7Vve0jmSWgq0ysPHfARLYjglaArDsxraghoZ
	 Qct/X5vtOCB9/1mxihkhByvIgBjdWtKI9MJnIZRMnS9pyzCJAGXTFEk9PVkH+QV87QBY3
	 n3+USBLK1YzhQm8fvntBQzfONSTaGJkxbJsoMcVnDzdC5s+IpRLfsH82jX4HTqBNwSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=YAFva3L5;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31F2606A31D
	for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2026 17:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E31F2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=YAFva3L5
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j7jsn4wFmz1XM6JB;
	Mon, 19 Oct 2026 17:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1792432604; x=1795024605; bh=O74b0
	zaJiBy9pbR1A6GrNxAyLKlyg1PUDTmkPeBPHNU=; b=YAFva3L5c5K3hzoHGDoYV
	5WegcgwGzgiaZ7+3wxs1mXza8yK9LVFp/EENMUGmF5SK2T4LtYfFdSIFQcSlGoLL
	BFmrpusFhhUKO2K8qv1bdJRaflsZZrCZcWcyx00Xrj82GN8OWepcMDiFTA6Vg3Oy
	mfk93+jw+Unchohv0C6RrSM0lOGJ/nO68xFh7RbzZVM6FDPRTQNE5mQa4H3cBFsF
	uyAauhdnIVfFoVYyxI4CfMCxrlHlAgTPpLm8br4vjrufDt/UArcuDhxxIXm77uyi
	CDVz4x7pT5Xzox67tKxnENxKueF+OQ35lQzSVqUJ5vydlAYojTwTadb2Y/UfBBAZ
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 0NCw6Xf6WBwA; Mon, 19 Oct 2026 17:56:44 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (245.199.118.34.bc.googleusercontent.com [34.118.199.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j7jsk5W8Pz1XM30n;
	Mon, 19 Oct 2026 17:56:42 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 04/20] storage: Free hash table entries when freeing storage
Date: Mon, 19 Oct 2026 10:56:17 -0700
Message-ID: <20261019175633.415493-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261019175633.415493-1-bvanassche@acm.org>
References: <20261019175633.415493-1-bvanassche@acm.org>
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Post: <mailto:linux-sparse@vger.kernel.org>
List-Help: <mailto:linux-sparse+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sparse+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Free allocated hash table entries when freeing storage structures in
storage.c to prevent memory leaks during storage teardown.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 storage.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/storage.c b/storage.c
index 6fc6e3d7085f..160d424ee1f6 100644
--- a/storage.c
+++ b/storage.c
@@ -159,12 +159,18 @@ static void vrfy_storage(struct storage_hash_list *=
*listp)
=20
 void free_storage(void)
 {
+	struct storage_hash_list *all =3D NULL;
 	int i;
=20
 	for (i =3D 0; i < MAX_STORAGE_HASH; i++) {
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
=20
 const char *show_storage(struct storage *s)
@@ -208,7 +214,7 @@ static struct storage * combine_storage(struct storag=
e *src, struct storage *dst
=20
 	/* Mark it unused */
 	src->type =3D REG_BAD;
-	src->users =3D NULL;
+	free_ptr_list(&src->users);
 	return dst;
 }
=20
