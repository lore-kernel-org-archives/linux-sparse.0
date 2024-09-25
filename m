Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8535F18B486
	for <linux-sparse@vger.kernel.org>; Wed, 25 Sep 2024 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276531; cv=none; b=BZxA4O2uZwxLNF9t+N6WahLhkIj3CuA6mLU8iw+DJQnvw02uElNlBH+7TRVyKDGFc3UgTnvQZU2zBHGsIERcN/KO6avpc/DTbdTnDbOGfYf9K7W6m7ZtWRTL3Fuj815uvmY7p2fEDRc6Ll2l5gv2av7VvOEBBYldV0eZogfUHs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276531; c=relaxed/simple;
	bh=rvAMLnpCc/KpfZ5R41lgUDfd/m3KQZyhOktFD8tg98U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tgPhtuXbRqeZDbX+dfdzinV+6MsYQskNeJa+rdMrHE/u2wLe11CJO4fv2emV7Ie3cH6+jD6A38qC21QW3GQPCXM25VTccG10EWrhe4PpeBjxCw1XCm2Mpumy7IeTFMxcncQUs3VTOD7jJfSfGY+OYF6i/GlKz94ZzXnXbJM6Nkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1NrzdrvG; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1NrzdrvG"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2146737f2so28267627b3.1
        for <linux-sparse@vger.kernel.org>; Wed, 25 Sep 2024 08:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727276527; x=1727881327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rTUv2yGZRT/iYzBSyilbN8CQ+H5OcaG9Xif73xCYTUU=;
        b=1NrzdrvGdFOoEJwA4NtSHJQuS2Au5gVzJYv/mFcE0Np8PSGy7tvIwAJ8IcidVu1OW3
         HfbC0gEqMOMFnsGAuqFKZWHsJSghaCD97sOZA9LtJjQfIEeTk7cUyfOynR9O2FeJexmD
         HDQ2qSS07oE3ZH4eiub+QmUsjHVbeLaHC9HiAMjrX3gnNK/BtsA0rbdLBoAH8Qg8ZmCb
         aJ9bqILDvZJGWyBFmkdEpl8U6mudNXXh2Pqf3gnFpJ2o0qdm/k6ueQ9BbPJVTubyusW3
         LnpWqnDYqttPTKuPaCsel2Xhjy5DspsKnryXSvBWpE0b8KIaiPHQoBfe/upLfjB9qW08
         HZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276527; x=1727881327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rTUv2yGZRT/iYzBSyilbN8CQ+H5OcaG9Xif73xCYTUU=;
        b=mqYbX+RFOW04zg5ht3tgmkzLmbf2CvVc/l9MI8lcW21vpDWAwrIkyvSa/S2vd+2YLX
         cNCREKW1c3UBIgjx0t2Fs6XmMLLt55K++G+N8pBoaFS1XxkSGiStHAExYlPzrVNpSx7N
         EmNkqo2sO2lTBBMDCdAquZn7tSmMkjF4BPAJTfzyh+sU1m93D3dqAsmAvsSpnW9V83F/
         DYgS/WufapD2ygaXnxL5tBLoIe8SAthwZQnZL/qx902Db3ZPQf00+nYnAGQJT8AmjJew
         GXayT4z7KbOFqxE9ej0eZAbHsCCMTyj/8zFDn2FAnT/BMgOFUxZhcLGFBVFAvqsDEPsx
         p0bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlCEXPOl6Mlx9z9duUrQkkesEz9+TTG616ZgUZf1z+sj2FNZhPoLomyclVsFw1Wnp+h1rslI6RQ2qkG9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZrsGJDgzjunEcqeTaxNhxTKNkViwdyEqbvqaij48klurNUtfk
	GtRxeE3sQr/VdDKphFGJfnl+qN9MXw3CisekUBqzHaR55qIW8HWZED4TojilsEVImFGA2Q==
X-Google-Smtp-Source: AGHT+IGLT7yTqD1HRbp0g+dVaksf1xzveaZLP+yFkMN9Z3pXXXvCU4M/LA5dyeTTzQHsrcQFQ2z7Ogbs
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:3583:b0:6b0:57ec:c5f9 with SMTP id
 00721157ae682-6e21d0dc0d2mr147787b3.0.1727276527085; Wed, 25 Sep 2024
 08:02:07 -0700 (PDT)
Date: Wed, 25 Sep 2024 17:01:07 +0200
In-Reply-To: <20240925150059.3955569-30-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=882; i=ardb@kernel.org;
 h=from:subject; bh=h9wNxRa08o4eoAqCSyYKOZyZKBTJUImThQPxe9qE/+Y=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe2L6taH/xoldmidSK479WfKnGWr8jq4V3v+610hdCLdd
 HLxEtXHHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiB3cwMjS+ttry3/KZyAZx
 s7TOmpSVs1htspZOu2OitnHlgdL1srsY/goaVByePZOfkbc43zeoadWW9TLmExXTXvxNfTl7XfX dejYA
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240925150059.3955569-37-ardb+git@google.com>
Subject: [RFC PATCH 07/28] scripts/kallsyms: Avoid 0x0 as the relative base
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Uros Bizjak <ubizjak@gmail.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

In some cases, LLVM's lld linker may emit the following symbol into the
symbol table

0000000000000000 ? _GLOBAL_OFFSET_TABLE_

and its presence throws off the relative base logic in kallsyms. Since
0x0 is never a valid relative base, just ignore it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 scripts/kallsyms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 03852da3d249..09757d300a05 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -747,7 +747,7 @@ static void record_relative_base(void)
 	unsigned int i;
 
 	for (i = 0; i < table_cnt; i++)
-		if (!symbol_absolute(table[i])) {
+		if (table[i]->addr && !symbol_absolute(table[i])) {
 			/*
 			 * The table is sorted by address.
 			 * Take the first non-absolute symbol value.
-- 
2.46.0.792.g87dc391469-goog

