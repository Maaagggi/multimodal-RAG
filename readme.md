# 📚 Multimodal Document Retrieval with Llama 3.2 and ColQwen2

This project presents an enhanced implementation of Together.ai's [OCR-free multimodal document retrieval system](https://www.together.ai/blog/multimodal-document-rag-with-llama-3-2-vision-and-colqwen2). While their original implementation demonstrates the capabilities of processing individual documents, our system extends this foundation to efficiently handle entire document repositories. Through sophisticated batch processing and unified vector storage, we enable comprehensive document analysis and retrieval at scale.

## 🌟 Key Enhancements

Our implementation transcends the original single-document limitations through several key innovations:

- **Comprehensive Document Processing**: Seamlessly handles multiple PDFs within a directory structure
- **Unified Vector Architecture**: Implements a cohesive vector store that maintains relationships across all documents
- **Enhanced Context Management**: Preserves semantic connections between documents during retrieval
- **Optimized Batch Processing**: Efficiently processes document collections while maintaining system performance

## 🧠 Technical Architecture

Building upon Together.ai's OCR-free methodology, our system integrates:

- **ColQwen2**: Leverages advanced vision-language understanding for document comprehension
- **Llama 3.2**: Utilizes sophisticated vision capabilities for enhanced image interpretation
- **Vector Storage**: Implements an optimized embedding structure for efficient multimodal retrieval
- **RAG Pipeline**: Enhanced for seamless multi-document context preservation

### Core Components:

1. **Document Processing Pipeline**:
   - Efficient PDF to image transformation
   - Sophisticated visual layout analysis via ColQwen2
   - Intelligent text region identification without OCR dependency
   - Cross-document context preservation mechanisms

2. **Retrieval System**:
   - Unified vector indexing across document collections
   - Advanced relevance scoring incorporating multi-document context
   - Coherent response generation leveraging comprehensive document understanding

## 📦 Requirements

Before running this project, ensure you have the following installed:

- Python 3.7 or higher
- pip (Python package installer)

### Python Packages

This project requires the following Python packages:

- `byaldi==0.0.5` (for ColQwen2 integration)
- `together==1.3.3` (for Llama 3.2 access)

### System Dependencies

This project requires `poppler-utils` for PDF processing.

## 🛠️ Local Setup

### 1. Clone the Repository

```bash
git clone https://github.com/Maaagggi/multimodal-RAG.git
cd multimodal-RAG
```

### 2. Install Python Packages

```bash
pip install -r requirements.txt
```

### 3. Install System Dependencies

The project requires `poppler-utils` for PDF processing. Depending on your operating system, follow the appropriate instructions:

- **For Ubuntu/Debian:**
    ```bash
    sudo apt-get install -y poppler-utils
    ```

- **For macOS:**
    ```bash
    brew install poppler
    ```

- **For Windows:**
    1. Download the latest version of Poppler for Windows from [Poppler for Windows](http://blog.alivate.com.au/poppler-windows/)
    2. Extract the downloaded ZIP file to a directory of your choice (e.g., `C:\Program Files\Poppler`)
    3. Add the `bin` directory (where `pdftoppm.exe` is located) to your system's PATH environment variable

### 4. Quick Install Script

For convenience, use our automated installation script:

```bash
chmod +x install.sh
./install.sh
```

## 🎯 Usage

### Basic Implementation

```python
# Initialize the ColQwen2 Model
model = RAGMultiModalModel.from_pretrained("vidore/colqwen2-v0.1")

# Configure document directory
knowledge_base_path = "/content/drive/MyDrive/gii"
index_name = "dir_doc_index"

# List all PDF files in the knowledge base directory
files = [f for f in os.listdir(knowledge_base_path) if f.endswith('.pdf')]

# Check if there are any PDF files to index
if not files:
    print("No PDF files found in the specified directory.")
else:
    print("Documents found for indexing:")
    for file in files:
        print(f"- {file}")

    # Index the first document
    first_file_path = Path(knowledge_base_path) / files[0]
    print(f"\nIndexing document: {files[0]}")
    model.index(input_path=first_file_path, index_name=index_name, store_collection_with_index=True, overwrite=False)

    # Add the remaining documents to the same index
    for file in files[1:]:  # Start from the second file
        file_path = Path(knowledge_base_path) / file
        print(f"Indexing document: {file}")
        model.add_to_index(input_item=file_path, store_collection_with_index=True)

    print("All documents indexed successfully!")


# Lets query our index and retrieve the page that has content with the highest similarity to the query

query = "find how india has performed in the rankings in 2022 and 2023"
results = model.search(query, k=5)  # Retrieve more results to cover multiple documents

# Group results by document and find the page with the highest score in each document
best_results = {}
for result in results:
    doc_id = result.doc_id
    if doc_id not in best_results or result.score > best_results[doc_id].score:
        best_results[doc_id] = result
        # Print the document and page information when a new best result is found
        print(f"Document: {result.doc_id}, Page: {result.page_num}, Score: {result.score}")

```

### Advanced Features

1. **Batch Document Processing**:
   - Automatic handling of multiple documents
   - Progress tracking and error handling
   - Configurable processing parameters

2. **Cross-Document Query Processing**:
   - Contextual understanding across documents
   - Relevance ranking across entire collection
   - Coherent response generation

## 🔍 How It Works

1. **Document Ingestion**:
   - Converts PDFs to images while preserving layout
   - Processes visual elements using ColQwen2
   - Creates semantic embeddings for content

2. **Indexing**:
   - Builds unified vector store for all documents
   - Maintains document relationships
   - Optimizes for quick retrieval

3. **Query Processing**:
   - Processes user queries across entire document set
   - Retrieves relevant content from multiple documents
   - Generates coherent responses using Llama 3.2


## 📖 References

- [Original Together.ai Implementation](https://www.together.ai/blog/multimodal-document-rag-with-llama-3-2-vision-and-colqwen2)
- [Llama 3.2 Documentation](https://docs.together.ai/docs/inference)
- [ColQwen2 Technical Details](https://together.ai/blog/colqwen2)

## 💡 Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Submit a pull request

## 📬 Contact

For technical inquiries or implementation assistance, please reach out via email at mageswaranmeyyappan@example.com.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Happy coding! 🎉