Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C2D13AE9
	for <linux-sparse@vger.kernel.org>; Mon, 15 Jan 2024 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EZVZyi1d"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e800461baso1116825e9.3
        for <linux-sparse@vger.kernel.org>; Mon, 15 Jan 2024 02:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705314729; x=1705919529; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RFn6tdE7ltotd+nh7DX9t7GuTBKXZfbeZSU2UvI8+r8=;
        b=EZVZyi1dQ2IRJdBMYZ6+CqonsUqfLqssqoH3woCxnEezvYtvGa4DGmuFmpJ1HNoVw3
         We++wa+VLMWsDHh0IfD+Gwmj5aXm/wHlqLXH3oDqLVUifSy6G1t7rWJA2RMWvKrErzQd
         x4+tiE3sjZqT8tgl8Izqb51odgLhP0WqLB+mZQt8/5phca6xjlkXoQnbrd36ap7HgLLP
         hshCFN/iBL5nKp21j8Rew7/EuMY4vR04v0EjVKaS+JIsfiJnKz4egqs2kRTXY2kPPp2B
         s6JoCrkB4f4E10hXldVUp+FTZW3GLWuRkPQZ6uxYy1rb40Y+TzyZBMr01PkTCex20bSm
         oYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705314729; x=1705919529;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFn6tdE7ltotd+nh7DX9t7GuTBKXZfbeZSU2UvI8+r8=;
        b=nXGV+9Qzap0Q0wIGWuBmdDKu0SzlNlovxXnmrcJt/F+L4kCiBwcYiPy4q+OAP2Pq/b
         nMdfEw/ASLoQOtdHOytWJDsHJmc5b7Cgwry2Ydu+iQE/pmS18vT+zSaqdPuzR8NxcwbH
         2YZT62oITsLHnclbrNSv0a6Rr65iUwYBCzfv+XfFJVpapJSu8S9fn0nfZyV64xMcgAT8
         WE7AsXtN4bd1RGvDvIYi0AxB8kNP/+Fp73WpfF4WsMnEMVIVBVCJe72OoH/BeQHWsDEH
         CRuhCljvghLGVH8c8r3qSeUUP1zCu5i6ytvBXikygzyn6uXGQbRWUIYhT/plZGnVz0hA
         lbYA==
X-Gm-Message-State: AOJu0YycakbtczfLLojt64fKfpnSGMn43RtukVagqrLxRDa+IQrK/8W5
	j7OOu0+cHEgB39eqQjCidouSJ3ht1L2RnA==
X-Google-Smtp-Source: AGHT+IFAK4iKNDC5v52b5pCvfQPOn5rkgnbxY2Q3L5wEfSUSQg25HqPe6kmHG6Lsqt17jpO/cTvihA==
X-Received: by 2002:a05:600c:6a19:b0:40e:67e9:af0 with SMTP id jj25-20020a05600c6a1900b0040e67e90af0mr1463679wmb.252.1705314728993;
        Mon, 15 Jan 2024 02:32:08 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d4c50000000b00337464bf71bsm11456719wrt.39.2024.01.15.02.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 02:32:08 -0800 (PST)
Date: Mon, 15 Jan 2024 13:32:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	linux-sparse@vger.kernel.org
Subject: Compile errors with LLVM v17
Message-ID: <91bbfbf8-d84d-4b4e-861d-c1cdbfcd56e6@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

I upgraded my Debian system and started getting compile errors with LLVM
version 17.  Apparently those APIs will need to be changed.
https://llvm.org/docs/OpaquePointers.html

regards,
dan carpenter

sparse-llvm.c: In function ‘get_sym_value’:
sparse-llvm.c:305:34: warning: implicit declaration of function ‘LLVMConstGEP’; did you mean ‘LLVMConstGEP2’? [-Wimplicit-function-declaration]
  305 |                         result = LLVMConstGEP(data, indices, ARRAY_SIZE(indices));
      |                                  ^~~~~~~~~~~~
      |                                  LLVMConstGEP2
sparse-llvm.c:305:32: warning: assignment to ‘LLVMValueRef’ {aka ‘struct LLVMOpaqueValue *’} from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
  305 |                         result = LLVMConstGEP(data, indices, ARRAY_SIZE(indices));
      |                                ^
sparse-llvm.c: In function ‘calc_gep’:
sparse-llvm.c:488:16: warning: implicit declaration of function ‘LLVMBuildInBoundsGEP’; did you mean ‘LLVMBuildInBoundsGEP2’? [-Wimplicit-function-declaration]
  488 |         addr = LLVMBuildInBoundsGEP(builder, base, &off, 1, name);
      |                ^~~~~~~~~~~~~~~~~~~~
      |                LLVMBuildInBoundsGEP2
sparse-llvm.c:488:14: warning: assignment to ‘LLVMValueRef’ {aka ‘struct LLVMOpaqueValue *’} from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
  488 |         addr = LLVMBuildInBoundsGEP(builder, base, &off, 1, name);
      |              ^
sparse-llvm.c: In function ‘output_op_load’:
sparse-llvm.c:714:18: warning: implicit declaration of function ‘LLVMBuildLoad’; did you mean ‘LLVMBuildLoad2’? [-Wimplicit-function-declaration]
  714 |         target = LLVMBuildLoad(fn->builder, addr, name);
      |                  ^~~~~~~~~~~~~
      |                  LLVMBuildLoad2
sparse-llvm.c:714:16: warning: assignment to ‘LLVMValueRef’ {aka ‘struct LLVMOpaqueValue *’} from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
  714 |         target = LLVMBuildLoad(fn->builder, addr, name);
      |                ^
sparse-llvm.c: In function ‘output_op_call’:
sparse-llvm.c:822:18: warning: implicit declaration of function ‘LLVMBuildCall’; did you mean ‘LLVMBuildCall2’? [-Wimplicit-function-declaration]
  822 |         target = LLVMBuildCall(fn->builder, func, args, n_arg, name);
      |                  ^~~~~~~~~~~~~
      |                  LLVMBuildCall2
sparse-llvm.c:822:16: warning: assignment to ‘LLVMValueRef’ {aka ‘struct LLVMOpaqueValue *’} from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
  822 |         target = LLVMBuildCall(fn->builder, func, args, n_arg, name);
      |                ^

