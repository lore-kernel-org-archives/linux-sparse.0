Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F728480
	for <linux-sparse@vger.kernel.org>; Tue, 16 Jan 2024 00:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="Ushim5Jw"
Received: from [10.0.2.15] ([195.213.6.126])
	by smtp with ESMTPA
	id PXezrFEhWEaYuPXf0ryAkF; Tue, 16 Jan 2024 00:50:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1705366235; bh=SljzJ4vZql+XeEHS2z4GMDmdnC2bXe5nVCsTyVaOSnk=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=Ushim5Jw5ahJduCtCyPlEiIuXVBs84vYVVlhf2I3N7cpravGIe6jSdjalqZg/fzBM
	 qJ3JUfWJVEEEz9RU7CMPTEP8Okg8NuLqw3b54SSY1eAUk4cBPMSy+w0Z17Fx1PYFWD
	 8zmEgRFpoHWkhVKFDM4sOWf+gZNG32fRQzHxAPOYvdxRqOLEA7DGUi9mTZuhJHkQ4M
	 JSE9zZWSOvqDy4WxGNMPCHbDHL0Z5Wr6fYjMA2KsuZq9PsnFDIvGyrVIPn/uqaZNJg
	 o9aJzlFecAEtCH/2D4hjDcPYRa3XZwnwn/tFLChWMZdvLGP9cNblicGmMxug+LnJ0V
	 Xvnc9CH+SNdNQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=YJqMdDKx c=1 sm=1 tr=0 ts=65a5d2db
 a=I2fX/nZaHmMJGYqJQXdKfg==:117 a=I2fX/nZaHmMJGYqJQXdKfg==:17
 a=IkcTkHD0fZMA:10 a=Twlkf-z8AAAA:8 a=PU-skFq93H-bw-dHlDYA:9 a=QEXdDO2ut3YA:10
 a=xO_kOj_IbHwA:10 a=-74SuR6ZdpOK_LpdRCUo:22
X-AUTH: ramsayjones@:2500
Message-ID: <8d6c2b91-87cc-4252-bc4e-13cce7c9ff6c@ramsayjones.plus.com>
Date: Tue, 16 Jan 2024 00:50:33 +0000
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Compile errors with LLVM v17
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 linux-sparse@vger.kernel.org
References: <91bbfbf8-d84d-4b4e-861d-c1cdbfcd56e6@moroto.mountain>
Content-Language: en-GB
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <91bbfbf8-d84d-4b4e-861d-c1cdbfcd56e6@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDOhG0pMno3hs3HmW1Ejnvp0xgeO2DhYsAB4IOScLXEY2e1etdAPEnmgijJrCGzyEYtVmw/IXNY63lRsOzycNbr4F69hAKp011Of83iP1GEbM5y+8uJi
 y0V7yw8GgVqYE33lsF3uIystqN+MAYGqJkr7OF4S45vkIrkdVQLfQb2IvPpNx3dw2nJ1GWPJ21OREYgWLHqTiHyCzCfOl3WPD04=



On 15/01/2024 10:32, Dan Carpenter wrote:
> I upgraded my Debian system and started getting compile errors with LLVM
> version 17.  Apparently those APIs will need to be changed.
> https://llvm.org/docs/OpaquePointers.html

Yep, I recently updated to LLVM version 14 and these APIs are shown
as deprecated (sparse-llvm is still built):

  $ make
  Makefile:170: Your system does not have sqlite3, disabling semind
  Makefile:192: Your system does not have gtk3/gtk2, disabling test-inspect
    CC      compile.o
    ...
    CC      sparse-llvm.o
  sparse-llvm.c: In function ‘get_sym_value’:
  sparse-llvm.c:305:25: warning: ‘LLVMConstGEP’ is deprecated [-Wdeprecated-declarations]
    305 |                         result = LLVMConstGEP(data, indices, ARRAY_SIZE(indices));
        |                         ^~~~~~
  In file included from /usr/lib/llvm-14/include/llvm-c/Core.h:18,
                   from sparse-llvm.c:6:
  /usr/lib/llvm-14/include/llvm-c/Core.h:2157:18: note: declared here
   2157 |     LLVMValueRef LLVMConstGEP(LLVMValueRef ConstantVal,
        |                  ^~~~~~~~~~~~
  /usr/lib/llvm-14/include/llvm-c/Deprecated.h:29:3: note: in definition of macro ‘LLVM_ATTRIBUTE_C_DEPRECATED’
     29 |   decl __attribute__((deprecated))
        |   ^~~~
  sparse-llvm.c: In function ‘calc_gep’:
  sparse-llvm.c:488:9: warning: ‘LLVMBuildInBoundsGEP’ is deprecated [-Wdeprecated-declarations]
    488 |         addr = LLVMBuildInBoundsGEP(builder, base, &off, 1, name);
        |         ^~~~
  In file included from /usr/lib/llvm-14/include/llvm-c/Core.h:18,
                   from sparse-llvm.c:6:
  /usr/lib/llvm-14/include/llvm-c/Core.h:3904:18: note: declared here
   3904 |     LLVMValueRef LLVMBuildInBoundsGEP(LLVMBuilderRef B, LLVMValueRef Pointer,
        |                  ^~~~~~~~~~~~~~~~~~~~
  /usr/lib/llvm-14/include/llvm-c/Deprecated.h:29:3: note: in definition of macro ‘LLVM_ATTRIBUTE_C_DEPRECATED’
     29 |   decl __attribute__((deprecated))
        |   ^~~~
  sparse-llvm.c: In function ‘output_op_load’:
  sparse-llvm.c:714:9: warning: ‘LLVMBuildLoad’ is deprecated [-Wdeprecated-declarations]
    714 |         target = LLVMBuildLoad(fn->builder, addr, name);
        |         ^~~~~~
  In file included from /usr/lib/llvm-14/include/llvm-c/Core.h:18,
                   from sparse-llvm.c:6:
  /usr/lib/llvm-14/include/llvm-c/Core.h:3892:18: note: declared here
   3892 |     LLVMValueRef LLVMBuildLoad(LLVMBuilderRef, LLVMValueRef PointerVal,
        |                  ^~~~~~~~~~~~~
  /usr/lib/llvm-14/include/llvm-c/Deprecated.h:29:3: note: in definition of macro ‘LLVM_ATTRIBUTE_C_DEPRECATED’
     29 |   decl __attribute__((deprecated))
        |   ^~~~
  sparse-llvm.c: In function ‘output_op_call’:
  sparse-llvm.c:822:9: warning: ‘LLVMBuildCall’ is deprecated [-Wdeprecated-declarations]
    822 |         target = LLVMBuildCall(fn->builder, func, args, n_arg, name);
        |         ^~~~~~
  In file included from /usr/lib/llvm-14/include/llvm-c/Core.h:18,
                   from sparse-llvm.c:6:
  /usr/lib/llvm-14/include/llvm-c/Core.h:3992:18: note: declared here
   3992 |     LLVMValueRef LLVMBuildCall(LLVMBuilderRef, LLVMValueRef Fn,
        |                  ^~~~~~~~~~~~~
  /usr/lib/llvm-14/include/llvm-c/Deprecated.h:29:3: note: in definition of macro ‘LLVM_ATTRIBUTE_C_DEPRECATED’
     29 |   decl __attribute__((deprecated))
        |   ^~~~
    LD      sparse-llvm
  $ 

Since I don't know anything about LLVM, I have been compiling like so:

  $ make LLVM_CONFIG=false

just to suppress the warnings (and it runs 42 less tests!). I have been
meaning to implement a make variable to suppress the sparse-llvm build
which can be placed into 'local.mk' ... but, well I never seem to have
enough round tuits! :)

ATB,
Ramsay Jones


