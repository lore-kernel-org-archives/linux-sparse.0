Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904E51E492D
	for <linux-sparse@vger.kernel.org>; Sun, 28 Sep 2025 04:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759034730; cv=none; b=FmoCauLXmHoGV/s1zU9eXeW2OSaUZUr2qe8gZUVB8kdhafHgqr2pTlVhD1x2K6sfR/a3qLFD1OiT4hs4hh3t4+26LodX64NFY4P/3qM7mogE3cRylyZvcomKGWQDDsOIUG3stbD2tf2lkeVJ1TkyNrXCVBw7e9mpLLuaQOls6RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759034730; c=relaxed/simple;
	bh=og7nVdmdx2KWScj5qQxDqxcXWUNKfyAeGc9l+znixAc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GWGaFdoUX8UPG86YPOKAXL9m7FVYdeYWeAPWn9ucJ9LlM9xXBpBQIBxeXNPUiFhYR0PYCaTAuMQ8fqp1gryPSjEkRrAmOaInaw5fhlzhtqx9KCz7BceY56a6hJR4lLtr8Q1HsEeAji1KyqxN+4clK8oYxkuUWLpyqwCNJu7Oeeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-62bbc95b4dfso3142219d50.2
        for <linux-sparse@vger.kernel.org>; Sat, 27 Sep 2025 21:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759034727; x=1759639527;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=og7nVdmdx2KWScj5qQxDqxcXWUNKfyAeGc9l+znixAc=;
        b=PycELSKfXry43eUFckjNwDnzsp3SQYKht++hmzO6kWjht6MX1fMbWaSmHWEkkyyngS
         VGZkyQHBG4xj5Q6LZUFr0fMUls6DkgF015pCHTxK9lpKmqkjveUCOj76Fo+4TvZwcIa6
         mP4V5eUgNW/Vd8sZGMLjRPau7pEdWJ9KMsZpmn2qJX7VffOQbjk3gPAaCryKmqLbFqIv
         j3J8dbixz5aso37a+ACDVqg5f7L5XUMG59Ik1CFkSGYOWnsPt1DelyCFMAsrHFNbFdUv
         4kY5SqpA7X0UWOk0Ow4wNFUULBeTOd4e3bHOV8h4MYwUVUm/zdcFnGXxBTwRHWi81E2B
         k1sQ==
X-Gm-Message-State: AOJu0YyQxW8V6tjEoyGkCGXj6tNCQTv5PDcCI6K6Q3dP7777ogrpdb2O
	ZO0MI6aFdnARGgHufoj4sC+CwyiV1DL4nsWWwiV1tL3dY90zpKesCvboP9IsgHyey0d3kU7bfO1
	gIqo70rt5D+DqKREFsWdfo9T6d9S5mOcJ5MpARe9pZ/DYWuCZtwYDH2skyw==
X-Gm-Gg: ASbGncscYuECZFg7/87aGQv/+vRoDsO6LC8yw1WcSm7W7t1+pCjM2nK4J3gFk/nu0Qv
	AAZY6FTIYuQ1xRb7tzdBJ6SUVbSJHSENXkQKMjxsSSGpuSIs+Y745rFVVoYVzEcHoD9/xuDIznc
	ZFjPz7jr1tR/wJUmDZaqmLrinoYRlDGuJzpzF6UfswvN0gIktzwuKAzmEfHzJahXVCj+eaolkji
	0Ye7H7z1vrICA2l
X-Google-Smtp-Source: AGHT+IH9R/Q+BB0tQHYmC9iCIfzoVuPLfR1tzvhkUz7a1Hmnmu89UhHDEGI8OSoCMwj3Be6X5GsZJrMN6JI+NQdrbbg=
X-Received: by 2002:a05:690e:5c7:b0:635:4ed0:571b with SMTP id
 956f58d0204a3-6361a838d87mr11575478d50.53.1759034727243; Sat, 27 Sep 2025
 21:45:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chris Li <sparse@chrisli.org>
Date: Sat, 27 Sep 2025 21:45:16 -0700
X-Gm-Features: AS18NWBNcpGAVbOUKerfGbBDaqgCVnvP0KAhdL0Ip0JEEcJ0wMdOHvMciH0jnKc
Message-ID: <CACePvbUajv=xC0J4eKdVoskRvKQDwxrM4v17+6t1M42xsbQ-gg@mail.gmail.com>
Subject: Sparse merge window is open
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, changyuan.lv@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

After a long break from sparse the project. I have fully returned back
to resume the maintainer role on sparse. I want to thank Luc for
taking great care of the project while I am gone. Looking forward to
the pull request from him again.

I am going through the mailing list for old patches that can be
applied to sparse but I haven't found much yet.

If you have patches that can be applied to sparse, now is a good time
to re-submit them. I want to cut a release after this round of merge
window.

Regarding the sparse vs sparse-dev repo. Here is how I intend to use
these two repo:
1) sparse repo. This is the stable repo, the git history will not
rewind. If something bad happens to the old commit, a revert commit
will be added to remove the problematic commit.
2) sparse-dev repo. This repo is always using sparse stable repo as
base. However the change newer than the sparse stable repo is not
guaranteed to be stable. I might rewind and re-apply a newer version
of the patches. Consider it as a staging repo. I will merge (fast
forward) from the sparse-dev to sparse at about weekly or bi-weekly
bases. Testing please use the sparse-dev repo for the cutting edge
changes.

If you want to submit patches to sparse, recommend using the stable
sparse repo as the base. Only use sparse-dev as base if there are very
bleeding edge patches that only exist on sparse-dev.

Pull request please use the sparse repo as well.

Another issue I want to collect some feedback is that, the kernel has
remove the sparse context checker:
https://lore.kernel.org/linux-sparse/20250918140451.1289454-23-elver@google.com/

Does any once feel strongly removing the lock context code in sparse
itself because the main usage case is now gone?

Chris
