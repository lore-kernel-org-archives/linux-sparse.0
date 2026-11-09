Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256410;
	b=xvlbTBYbmvEx+wmL0TqOtrdh64yOnSyCAAEeEE3o4KOSVuIDJEGpWgI0cnIep0nXHA4i
	 jeTkYLwO+Lln57ZqIrpVdkYdn0spAB1HniCdCrRKmfzXI2UJe18uXXa4POMVPMzm6g0eg
	 1IiF54LUNRsHgiBFXSSPJjlmOaL1gw37IE+OGvgABRZ5sUXtsOaGp3ycSoGiTQUaoL9DK
	 ugHhqbAQgGDiMec3h/25nZ6WdmroTXuauspmW5zQyMtOn1Rm0ZIQAsruzIB35FRP0NIqy
	 En3rlYt+xn8YAq4dI9UHXHT+LqBQpUOOzTlEOUiJ9CvxPNYAeBPCEPVEIaVQ7CXrTQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=CVZOP1ycdKWDSyDANKfUuzm/V5GTeB8gQ+IFFX9PHig=;
	b=iEr7a9u6QIVUquO/S3kQNVpJJ06Ljl05AmDGX/mHEYOEzrx97in3B0h8l1jQ+1bsKy97
	 sL4fioCU9vMPZufVSYqOUEyKB5M3yhJkt8vMjuCpx2qJAQ54PnS78e/+ULNOUI6oMSpEY
	 mOVZcTnHtUF8IBK1FgqS6U7OlKq/zpfgFY9RDvMN2TK36aAXIzDBAdk6CTCIhX0iz234U
	 2QH6KymYhp5ABtu9Lef+SFn0zrM2M0koEU/LEmEqk/qvDIgOZJ5/jjBXLkEuJyZjr4NZX
	 hsfKnsbHjVHE3r2J529qj+DuZ5NiubmnAGCvSSujihezZ9X2YrnHHRIvuyDlUOvYZBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=dpS4Vemb;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2733606A326
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2733606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=dpS4Vemb
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhLx2yxLz1XMYJM;
	Mon,  9 Nov 2026 20:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256407; x=1796848408; bh=CVZOP
	1ycdKWDSyDANKfUuzm/V5GTeB8gQ+IFFX9PHig=; b=dpS4VembpdHT84l4hAJ/X
	9rHmMNvqzz2Xx4H3/xFEZHIVKs4t1uYTnKnSm1IyJtRZwREXF7av5crONJ6zjIYH
	z21/NwwztvxvOzo2z56+M249lgkTM79ahsFb/Vu4TjrvVctv1c+5Y2JkxJlxS6yB
	6mpNjWIBjP9sCtJO1G00iUlrUNHhp6VZde5IPADVBdsRNFftst3v3WcPYklN/QRB
	xN89OFnjJL11csguNS7WGUrqwA6C2XBeET0oFxwbTHF40aEJwoZneWC6zTq/VCHs
	vtcZmMSpO9BPHcrtnFJbxenAIRIiZUhtuJ+g5qWr1kekKbqhpRQWUZCGba8/wviN
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id UTqVLiXggRvy; Mon,  9 Nov 2026 20:33:27 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLs2mD7z1XM0nk;
	Mon,  9 Nov 2026 20:33:25 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 05/73] allocate: Harden slab allocation bounds, zeroing, and mmap checks
Date: Mon,  9 Nov 2026 12:31:51 -0800
Message-ID: <20261109203259.362845-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109203259.362845-1-bvanassche@acm.org>
References: <20261109203259.362845-1-bvanassche@acm.org>
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

Harden allocator bounds and statistics handling in allocate.c and
compat/mmap-blob.c:
- Zero reused freelist blocks with memset() instead of a pointer-sized
  loop in allocate().
- Check size > chunking - offset before calling blob_alloc() so blob
  header alignment overhead cannot underflow blob->left.
- Guard show_allocations() against division by zero when no allocations
  occurred.
- Check power-of-two chunk rounding and 4096-byte page alignment in
  blob_alloc() and blob_free().

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 allocate.c         | 22 +++++++++++-----------
 compat/mmap-blob.c |  4 ++--
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/allocate.c b/allocate.c
index bef85192eab1..2aca1815e5f2 100644
--- a/allocate.c
+++ b/allocate.c
@@ -33,6 +33,7 @@
 #include <stdlib.h>
 #include <stddef.h>
 #include <stdio.h>
+#include <string.h>
=20
 #include "lib.h"
 #include "allocate.h"
@@ -88,10 +89,7 @@ void *allocate(struct allocator_struct *desc, unsigned=
 int size)
 		void **p =3D desc->freelist;
 		retval =3D p;
 		desc->freelist =3D *p;
-		do {
-			*p =3D NULL;
-			p++;
-		} while ((size -=3D sizeof(void *)) > 0);
+		memset(retval, 0, size);
 		return retval;
 	}
=20
@@ -100,17 +98,19 @@ void *allocate(struct allocator_struct *desc, unsign=
ed int size)
 	size =3D (size + alignment - 1) & ~(alignment-1);
 	if (!blob || blob->left < size) {
 		unsigned int offset, chunking =3D desc->chunking;
-		struct allocation_blob *newblob =3D blob_alloc(chunking);
+		struct allocation_blob *newblob;
+
+		offset =3D offsetof(struct allocation_blob, data);
+		offset =3D (offset + alignment - 1) & ~(alignment-1);
+		if (size > chunking - offset)
+			die("alloc too big");
+		newblob =3D blob_alloc(chunking);
 		if (!newblob)
 			die("out of memory");
-		if (size > chunking)
-			die("alloc too big");
 		desc->total_bytes +=3D chunking;
 		newblob->next =3D blob;
 		blob =3D newblob;
 		desc->blobs =3D newblob;
-		offset =3D offsetof(struct allocation_blob, data);
-		offset =3D (offset + alignment - 1) & ~(alignment-1);
 		blob->left =3D chunking - offset;
 		blob->offset =3D offset - offsetof(struct allocation_blob, data);
 	}
@@ -125,8 +125,8 @@ void show_allocations(struct allocator_struct *x)
 	fprintf(stderr, "%s: %d allocations, %lu bytes (%lu total bytes, "
 			"%6.2f%% usage, %6.2f average size)\n",
 		x->name, x->allocations, x->useful_bytes, x->total_bytes,
-		100 * (double) x->useful_bytes / x->total_bytes,
-		(double) x->useful_bytes / x->allocations);
+		100 * (double) x->useful_bytes / (x->total_bytes ?: 1),
+		(double) x->useful_bytes / (x->allocations ?: 1));
 }
=20
 void get_allocator_stats(struct allocator_struct *x, struct allocator_st=
ats *s)
diff --git a/compat/mmap-blob.c b/compat/mmap-blob.c
index 1cab4dead96d..91edeb9bc8d8 100644
--- a/compat/mmap-blob.c
+++ b/compat/mmap-blob.c
@@ -17,7 +17,7 @@ void *blob_alloc(unsigned long size)
 {
 	void *ptr;
=20
-	if (size & ~CHUNK)
+	if (!size || (size & (CHUNK - 1)))
 		die("internal error: bad allocation size (%lu bytes)", size);
 	ptr =3D mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON=
YMOUS, -1, 0);
 	if (ptr =3D=3D MAP_FAILED)
@@ -27,7 +27,7 @@ void *blob_alloc(unsigned long size)
=20
 void blob_free(void *addr, unsigned long size)
 {
-	if (!size || (size & ~CHUNK) || ((unsigned long) addr & 512))
+	if (!size || (size & (CHUNK - 1)) || ((unsigned long) addr & 4095))
 		die("internal error: bad blob free (%lu bytes at %p)", size, addr);
 #ifndef DEBUG
 	munmap(addr, size);
