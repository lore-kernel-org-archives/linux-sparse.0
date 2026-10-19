Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432613;
	b=hHVr7D3tzzky+ieTlvuiW7+Qn2nr9MA4MUbIuAE5iNEJCYJTgPjwjXGp3rr9K0dLGPYU
	 nI44DKFsX78LdofVJBfs8/hYlJYcZblt6sgqT4QsY33F4D8ZKmjo1/SZNmqTy4yFr9M5z
	 /GYEvHEgO1BRY1otFYiyau5elXdPog6L1EQCJqRRjr0qyq0md2cZlps97n0JitVQW26k6
	 HLRUcE++po3rMfp3JmlIW5IvQdsmlwoq7qCE9s7dW96d3hFPCK6IHzlCgr36Ks0o3QCUP
	 siV14x3Vyky0VVJOGnMAHNV31EekjYc5zxyCoDAtfrumKdJBboH0ZtajpmrS6BQV5nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=hsvGYhXwnhury2sooNDNZza4G0AWNuGEg+T/2spEHCo=;
	b=U+qmI/tSpk7LKfXBhapRHk9jjNFGdDeNF9f/Z5jKa0R9rbhIABIUu/niftgekoWM5sRP
	 kRDI6fhBv7PFMhH+8aq5JdzCaIIPwlT7mWyAaragLYrGXd47HCZKhuHN57+ZNbeJSR9KP
	 3qcPEuK8A3h1pqO7UGfUFSrvfeabuURLnGOEA6gAO4d2akFCKtbQB+QTMf1H85+n1CLKi
	 39kI5MspPkec98dLCNK6gb2ZPZ9xtIOsLvPMEpUxj5ONYhM8i3Z7HMuyzx9eMiNNbbsp6
	 6caSQLxtm0xK3slDMPqMk4MHkiv+GIgsHdaGSPkmvz69QMrnqUJcHoN1Mv1g5/yx7Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=ju01UNFY;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7DD606A319
	for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2026 17:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A7DD606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=ju01UNFY
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j7jsn5gxMz1XM30n;
	Mon, 19 Oct 2026 17:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1792432603; x=1795024604; bh=hsvGY
	hXwnhury2sooNDNZza4G0AWNuGEg+T/2spEHCo=; b=ju01UNFYXcgdKZKuZLiNe
	7PBXx4AZWuc/ke41ygge6/FGpdmiPvBrutC/BcnuzN3//cKEpGcFr2mMXABxgRyS
	di33h0+UaDiToJIV/tnm8XqI+nkOxi1rw/JPWPVNf9dBFkY7ezT4ZzbszbjN3r/E
	MdHHEczjHa+iGJ3ayEXG6HaT6Y/WOhojlv0vVspV71LA8QhNfm3rVgMDWxskOOEn
	9HEesVu29qfgR+SAyGkUxuexu6YSEdaw5JHmZooq8n+O8eF7GGICkDfWORwUWxAG
	Lxj+3SgUBV+84PWICwcvqHvMWTI6/ADtg45QeZXgCER+slvX5mgG0VTLtbM4env2
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id eoRHwKlwabeV; Mon, 19 Oct 2026 17:56:43 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (245.199.118.34.bc.googleusercontent.com [34.118.199.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j7jsk2JR7z1XM30g;
	Mon, 19 Oct 2026 17:56:42 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 02/20] ptrlist: Guard against null list in ptrlist operations
Date: Mon, 19 Oct 2026 10:56:15 -0700
Message-ID: <20261019175633.415493-3-bvanassche@acm.org>
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

Guard against null list pointers before accessing list->rm in ptrlist.h
and ptrlist.c to eliminate undefined behavior and UBSan null member
access traps.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 ptrlist.c | 47 +++++++++++++++++++++++++++++++++--------------
 ptrlist.h | 14 ++++++++++----
 2 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/ptrlist.c b/ptrlist.c
index c5766002e7ef..29fea6a35c70 100644
--- a/ptrlist.c
+++ b/ptrlist.c
@@ -165,19 +165,21 @@ void *ptr_list_nth_entry(struct ptr_list *list, uns=
igned int idx)
 int linearize_ptr_list(struct ptr_list *head, void **arr, int max)
 {
 	int nr =3D 0;
-	if (head && max > 0) {
+	if (head && max >=3D 0) {
 		struct ptr_list *list =3D head;
=20
 		do {
-			int i =3D list->nr;
-			nr +=3D i;
-			if (max =3D=3D 0)
-				continue;
-			if (i > max)=20
-				i =3D max;
-			memcpy(arr, list->list, i*sizeof(void *));
-			arr +=3D i;
-			max -=3D i;
+			int i;
+			for (i =3D 0; i < list->nr; i++) {
+				void *ptr =3D list->list[i];
+				if (list->rm && !ptr)
+					continue;
+				nr++;
+				if (max > 0) {
+					*arr++ =3D ptr;
+					max--;
+				}
+			}
 		} while ((list =3D list->next) !=3D head);
 	}
 	return nr;
@@ -247,6 +249,15 @@ void split_ptr_list_head(struct ptr_list *head)
 	newlist->nr =3D nr;
 	memcpy(newlist->list, head->list + old, nr * sizeof(void *));
 	memset(head->list + old, 0xf0, nr * sizeof(void *));
+	if (head->rm) {
+		int i, rm =3D 0;
+		for (i =3D 0; i < nr; i++) {
+			if (!newlist->list[i])
+				rm++;
+		}
+		newlist->rm =3D rm;
+		head->rm -=3D rm;
+	}
 }
=20
 ///
@@ -409,10 +420,18 @@ void * delete_ptr_list_last(struct ptr_list **head)
=20
 	if (!first)
 		return NULL;
-	last =3D first->prev;
-	if (last->nr)
-		ptr =3D last->list[--last->nr];
-	if (last->nr <=3D0) {
+	while ((last =3D first->prev)->nr =3D=3D 0) {
+		if (last =3D=3D first) {
+			*head =3D NULL;
+			__free_ptrlist(last);
+			return NULL;
+		}
+		first->prev =3D last->prev;
+		last->prev->next =3D first;
+		__free_ptrlist(last);
+	}
+	ptr =3D last->list[--last->nr];
+	if (last->nr <=3D 0) {
 		first->prev =3D last->prev;
 		last->prev->next =3D first;
 		if (last =3D=3D first)
diff --git a/ptrlist.h b/ptrlist.h
index 5a3dcbeb97ae..89f15d53fa13 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -11,7 +11,7 @@
  */
=20
 /* Silly type-safety check ;) */
-#define CHECK_TYPE(head,ptr)		(void)(&(ptr) =3D=3D &(head)->list[0])
+#define CHECK_TYPE(head,ptr)		(void)sizeof(&(ptr) =3D=3D &(head)->list[0=
])
 #define PTRLIST_TYPE(head)		__typeof__((head)->list[0])
 #define VRFY_PTR_LIST(head)		(void)(sizeof((head)->list[0]))
=20
@@ -163,15 +163,19 @@ extern void __free_ptr_list(struct ptr_list **);
=20
=20
 #define PTR_NEXT(ptr, __head, __list, __nr, PTR_ENTRY)			\
-	do {								\
+	for (;;) {							\
 		if (__nr < __list->nr) {				\
 			ptr =3D PTR_ENTRY(__list,__nr);			\
 			__nr++;						\
+			if (__list->rm && !ptr)				\
+				continue;				\
 			break;						\
 		}							\
 		ptr =3D NULL;						\
 		__nr =3D 0;						\
-	} while ((__list =3D __list->next) !=3D __head)			\
+		if ((__list =3D __list->next) =3D=3D __head)			\
+			break;						\
+	}			\
=20
 #define DO_PREPARE(head, ptr, __head, __list, __nr, PTR_ENTRY)		\
 	do {								\
@@ -224,7 +228,7 @@ extern void __free_ptr_list(struct ptr_list **);
 	__typeof__(head) __list =3D __head;				\
 	__typeof__(head) __name =3D __head;				\
 	int __nr;							\
-	if (!head)							\
+	if (!__head)							\
 		break;							\
 	do {								\
 		__list =3D __list->prev;					\
@@ -255,6 +259,8 @@ extern void __free_ptr_list(struct ptr_list **);
 	__inside##new:							\
 		while (--__newnr >=3D 0) {				\
 			new =3D PTR_ENTRY(__newlist,__newnr);		\
+			if (__newlist->rm && !new)			\
+				continue;		\
=20
 #define DO_THIS_ADDRESS(ptr, __head, __list, __nr)			\
 	(&__list->list[__nr])
