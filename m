Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A52246774
	for <linux-sparse@vger.kernel.org>; Thu,  9 Oct 2025 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020694; cv=none; b=WA7EnPB3G76sXubBAa0jguwxOCwSI8fVqWz2Gyu8r4QBZSovKw6bATybJTyqRoZ+1Eaqh/bBm3QvoTy2JAOXz7v4pseqfpaNPouvpd2BuTFGJWZTu6SrabdN7yj5KgeVW5XqAWYC9Z2eQFMY6efjtrgx8qNeatmZg6xGIEJtafo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020694; c=relaxed/simple;
	bh=5KOly8SptVUIJ43QAtgwaSIIsjh6dpCsyexunOh8eoM=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Content-Type; b=Q5OWseEC0MUbPZUbRNRLrgoW/mVPGywnVaek80UNllia7aNZHtdzBzfpezJQZNuDoVzZrqWNTv9X8I/Jdq9ujIW5FX1KHaJ5Nq7C4lKY5xMURpawoj9DtSiOjlcqoZZeP/7sEH2hO3D91vsvupgDWAYnNWqVPpAU/eVMO+EQMM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VG9C49RW; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VG9C49RW"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-869ecba3bd2so114375485a.0
        for <linux-sparse@vger.kernel.org>; Thu, 09 Oct 2025 07:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760020692; x=1760625492; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YvEKUGiCM22duMxgPmHzF9lPZk0+ipOiTyj4uaKR/AU=;
        b=VG9C49RWbiRkEoRrB0Wc6WV21Hse5ETBzQJmkP0urNumNvzJuH4EWafOVn3Wk5T1YB
         1l+xqZWgLPSFSQ+q/4/k2ktoZuK2ECY2U0CcXh9DJns1tEv489HLWtO4fhGOL2ugfCWB
         iVpPJ/UxvRp0Kk5FLm8F4C+jQt2072UeRUmZ45jFsAeG3GHR39jWD1Op/mEnSvwFemY2
         Qppa3BlMmlE4O+bsdSVqjzoFeVUC7D2zrrr3pjTtXMV4R2QREo2xKfO+8HC6xtqPQH3/
         uDiCspw3i7DclKhf2ThtQ5afIxXIIlG6WPh0Ua/+i5ep3SGCvb1B9xKQHLgaZ5ks2xj+
         j5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760020692; x=1760625492;
        h=to:subject:message-id:date:mime-version:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YvEKUGiCM22duMxgPmHzF9lPZk0+ipOiTyj4uaKR/AU=;
        b=RiI9HBpfFJrvSwUYb3lOqTOhx2L+D/mMRe9T9yCc4xngLzQatLWwAa0v4fV5cE12Mw
         QOx6tY47kTgiIjXkoEt8Rp3GbMEtbCFSFa+UbtmgRNm6ou3xQvJmbjZK6p9EJHzThtAa
         VzmmCTnhTTh1BGgk0wADTyNMI9NRupJgVKE4j5DJdLdU1qWiu4gd5d3A7jR28G/Bak9y
         2pFgdjhRm35k873rPE7PUhd5tkJMzAuruIpgjbbhYlyLcxtTCLW7tz6QbnZ6FKLAR/2T
         YUeOPliXBfMBEEeDwUwiWyilSqO16CReVB2ny1yf/XEMvBZN+W1OgpUhqUf2G5JDp5Dm
         iNHQ==
X-Gm-Message-State: AOJu0Yy9/9tECNhW/gN5yStgz1n3LWlRLqco35FneT2R/cPjj+9h8ri7
	DwCcEJ7AbrN0BfHU7oYISSzeHKAZUZ1nkoL9bjacusVfM8En3H/g3Dic8l4RGjO9HVwAiclklj8
	JChr9CZRtap40ffBQB52Bctfgb0MZ+a+mdyQ+
X-Gm-Gg: ASbGncuLmmHs2Xijg8sB5T2VraxmblhsyjXtfRutjKgjE3dAOZ0iCw4fa/apQuM6AWN
	3mzFUYJBld8bElb9jUySQyXRFWM9YlX/eMk3W4QRSxYO1mSyGo+VFoDmDxJvpWC9Kom4EfLfPf0
	I+UAZ+wlRl1xpo/ze7Z5uLLH1pbmpXXd+8uwozoQcKz1aIp28HKnQrG3SZcHndnCB0mO8iqGTQm
	zsKPc8A6y76Dm9TJHXeTgts5lg+
X-Google-Smtp-Source: AGHT+IFmmccGccjqJEiNyW6YjdAi912kJNr2XGa9VMJNObI5lR+ho7GUZWq8GxUQSltcBkQ1YG1Ks+VUyQ4dXqpoX68=
X-Received: by 2002:a05:620a:1791:b0:84d:f2b:ae9a with SMTP id
 af79cd13be357-883529b5d72mr1192291885a.11.1760020691610; Thu, 09 Oct 2025
 07:38:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Oct 2025 07:38:10 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Oct 2025 07:38:10 -0700
From: Amit Dhingra <mechanicalamit@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 9 Oct 2025 07:38:10 -0700
X-Gm-Features: AS18NWD4fNIRncqMg8Y5LoiH25V4RIE2H1AzDX3Nw0-1lnjaQpXfVYCk_7r6_04
Message-ID: <CAO=gReG3L4S90RZDTg+kx8M7jH7dG-AHKEnKJaq0OJLRfYQxug@mail.gmail.com>
Subject: [PATCH smatch] smdb.py : Clarify <function> comes before <type> in
 info option
To: linux-sparse@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Signed-off-by: Amit Dhingra <mechanicalamit@gmail.com>
---
 smatch_data/db/smdb.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/smatch_data/db/smdb.py b/smatch_data/db/smdb.py
index 29f1a339..13f1017c 100755
--- a/smatch_data/db/smdb.py
+++ b/smatch_data/db/smdb.py
@@ -19,7 +19,7 @@ except sqlite3.Error as e:
 def usage():
     print("%s" % (sys.argv[0]))
     print("<function> - how a function is called")
-    print("info <type> - how a function is called, filtered by type")
+    print("info <function> <type> - how a function is called,
filtered by type")
     print("return_states <function> - what a function returns")
     print("call_tree <function> - show the call tree")
     print("where <struct_type> <member> - where a struct member is set")
-- 
2.51.0
